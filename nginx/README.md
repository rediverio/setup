# Nginx Configuration

Nginx reverse proxy configuration for Rediver Platform with SSL/TLS support.

## Configuration

### Server Hostname (NGINX_HOST)

The server hostname is configured via the `NGINX_HOST` environment variable:

| Environment | Default | Required | Location |
|-------------|---------|----------|----------|
| Staging | `localhost` | No | `.env.nginx.staging` |
| Production | - | **Yes** | `.env.nginx.prod` |

**Examples:**
```bash
# Staging - localhost (default)
NGINX_HOST=localhost

# Staging - custom domain
NGINX_HOST=staging.example.com

# Production - your domain (required)
NGINX_HOST=example.com
```

### How it works

1. Server configuration is defined in `templates/default.conf.template`
2. Nginx docker image processes templates with `envsubst` on startup
3. `${NGINX_HOST}` is replaced with actual value from environment

## SSL Certificates

### Option 1: Self-Signed (Staging/Testing)

```bash
# Generate self-signed certificate
make init-ssl

# Start staging with SSL
make staging-up-ssl
```

**Note:** Self-signed certificates will show browser warnings. This is expected.

### Option 2: Let's Encrypt (Production)

```bash
# Show setup instructions
make init-ssl-letsencrypt
```

Or manually:

```bash
# 1. Install Certbot
sudo apt install certbot

# 2. Obtain certificate (stop any service on port 80 first)
sudo certbot certonly --standalone -d your-domain.com

# 3. Copy certificates
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem nginx/ssl/cert.pem
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem nginx/ssl/key.pem
sudo chmod 644 nginx/ssl/cert.pem
sudo chmod 600 nginx/ssl/key.pem

# 4. Update NGINX_HOST in .env.ui.prod
NGINX_HOST=your-domain.com

# 5. Start production
make prod-up
```

### Option 3: Commercial Certificate

1. Purchase SSL certificate from provider (DigiCert, Comodo, etc.)
2. Place certificate files in `nginx/ssl/`:
   - `cert.pem` - Certificate chain
   - `key.pem` - Private key

## Directory Structure

```
nginx/
├── nginx.conf                    # Main nginx configuration
├── templates/
│   └── default.conf.template     # Server block template (uses ${NGINX_HOST})
├── ssl/                          # SSL certificates directory
│   ├── .gitignore                # Ignore certificate files
│   ├── cert.pem                  # SSL certificate (you provide)
│   └── key.pem                   # SSL private key (you provide)
└── README.md                     # This file
```

## Management Commands

```bash
# Generate self-signed certificate
make init-ssl

# Show Let's Encrypt instructions
make init-ssl-letsencrypt

# Test nginx configuration
make nginx-test-staging    # Staging
make nginx-test-prod       # Production

# Reload nginx (after config changes)
make nginx-reload-staging  # Staging
make nginx-reload-prod     # Production

# View nginx logs
make nginx-logs-staging    # Staging
make nginx-logs-prod       # Production

# Reload after certificate renewal
make ssl-renew
```

## Security Notes

- Never commit SSL private keys to Git (`.gitignore` configured)
- Rotate certificates before expiry (Let's Encrypt: 90 days)
- TLS 1.2 and 1.3 only (older versions disabled)
- HSTS enabled with 1 year max-age
- Rate limiting: 10 requests/second per IP

## Certificate Renewal (Let's Encrypt)

```bash
# Renew certificates
sudo certbot renew

# Copy renewed certificates
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem nginx/ssl/cert.pem
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem nginx/ssl/key.pem

# Reload nginx
make ssl-renew
```

## Troubleshooting

### Certificate not trusted
- Ensure `cert.pem` contains the full certificate chain
- Check certificate validity: `openssl x509 -in nginx/ssl/cert.pem -text -noout`

### Permission denied
```bash
sudo chmod 644 nginx/ssl/cert.pem
sudo chmod 600 nginx/ssl/key.pem
```

### Nginx won't start
```bash
# Check logs
make nginx-logs-staging
# Or
make nginx-logs-prod

# Test config
make nginx-test-staging
# Or
make nginx-test-prod
```

### NGINX_HOST not working
- Ensure `.env.nginx.staging` or `.env.nginx.prod` exists
- Check that `NGINX_HOST` is set correctly in the env file
- Restart nginx after changing: `make staging-down && make staging-up-ssl`
