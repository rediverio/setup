-- =============================================================================
-- VN Security Team - Complete Asset Inventory Seed Data
-- =============================================================================
-- Comprehensive sample data covering ALL asset types for CTEM
-- Tenant: VN Security Team (bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb)
-- =============================================================================
-- Usage: psql -d rediver -f seed_vnsecurity_assets.sql
-- =============================================================================

-- Disable RLS for seeding
SET app.current_tenant = '';

-- Use VN Security Team tenant
-- Tenant ID: bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb

-- =============================================================================
-- ASSET INVENTORY - ALL TYPES
-- =============================================================================

INSERT INTO assets (id, tenant_id, name, asset_type, criticality, status, description, scope, exposure, risk_score, finding_count, tags, metadata, first_seen, last_seen, created_at)
VALUES
    -- =========================================================================
    -- 1. EXTERNAL ATTACK SURFACE
    -- =========================================================================

    -- =========================================================================
    -- DOMAINS (domain) - With Hierarchy (Best Practice)
    -- =========================================================================
    -- Domain hierarchy example:
    --   vnsecurity.io (level 1 - root)
    --   ├── api.vnsecurity.io (level 2)
    --   │   ├── v1.api.vnsecurity.io (level 3)
    --   │   └── v2.api.vnsecurity.io (level 3)
    --   ├── portal.vnsecurity.io (level 2)
    --   ├── staging.vnsecurity.io (level 2)
    --   │   └── api.staging.vnsecurity.io (level 3)
    --   ├── dev.vnsecurity.io (level 2)
    --   │   └── jenkins.dev.vnsecurity.io (level 3)
    --   └── *.vnsecurity.io (wildcard)
    -- =========================================================================

    -- Root Domain (Level 1)
    ('b0000001-0001-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsecurity.io', 'domain', 'critical', 'active',
     'Main company domain - Primary attack surface entry point (Root Domain)',
     'external', 'public', 45, 2,
     ARRAY['production', 'primary', 'public-facing', 'root-domain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 1,
       "parent_domain": null,
       "is_wildcard": false,
       "discovery_source": "manual",
       "registrar": "VNNIC",
       "registration_date": "2020-01-15",
       "expiry_date": "2026-12-31",
       "nameservers": ["ns1.cloudflare.com", "ns2.cloudflare.com"],
       "dns_record_types": ["A", "MX", "TXT", "NS"],
       "resolved_ips": ["103.45.67.10", "103.45.67.11"],
       "mx_records": ["mail.vnsecurity.io"],
       "dnssec_enabled": true,
       "spf": "v=spf1 include:_spf.google.com ~all",
       "dmarc": "v=DMARC1; p=reject; rua=mailto:dmarc@vnsecurity.io",
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    -- Level 2 Subdomains
    ('b0000001-0001-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'api.vnsecurity.io', 'domain', 'critical', 'active',
     'API Gateway subdomain (Level 2)',
     'external', 'public', 55, 3,
     ARRAY['production', 'api', 'gateway', 'subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "dns",
       "dns_record_types": ["A", "CNAME"],
       "resolved_ips": ["103.45.67.10"],
       "cname_target": "api-gateway.vnsecurity.io",
       "ttl": 300,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0001-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'portal.vnsecurity.io', 'domain', 'high', 'active',
     'Customer portal subdomain (Level 2)',
     'external', 'restricted', 35, 1,
     ARRAY['production', 'portal', 'customer', 'subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "cert_transparency",
       "dns_record_types": ["A"],
       "resolved_ips": ["103.45.67.12"],
       "ttl": 300,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    ('b0000001-0001-0001-0001-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'staging.vnsecurity.io', 'domain', 'medium', 'active',
     'Staging environment subdomain (Level 2)',
     'internal', 'restricted', 20, 0,
     ARRAY['staging', 'test', 'subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "dns",
       "dns_record_types": ["A"],
       "resolved_ips": ["10.0.100.10"],
       "ttl": 300,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    ('b0000001-0001-0001-0001-000000000005', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'dev.vnsecurity.io', 'domain', 'low', 'active',
     'Development environment subdomain (Level 2)',
     'internal', 'private', 15, 0,
     ARRAY['development', 'internal', 'subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "dns",
       "dns_record_types": ["A"],
       "resolved_ips": ["10.0.200.10"],
       "ttl": 60,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0001-0001-0001-000000000006', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'mail.vnsecurity.io', 'domain', 'high', 'active',
     'Mail server subdomain (Level 2)',
     'external', 'restricted', 40, 1,
     ARRAY['production', 'mail', 'subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "dns",
       "dns_record_types": ["A", "MX"],
       "resolved_ips": ["103.45.67.20"],
       "ttl": 3600,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    -- Level 3 Sub-subdomains
    ('b0000001-0001-0001-0001-000000000007', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'v1.api.vnsecurity.io', 'domain', 'high', 'active',
     'API v1 subdomain (Level 3)',
     'external', 'public', 50, 2,
     ARRAY['production', 'api', 'v1', 'sub-subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 3,
       "parent_domain": "api.vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "api_discovery",
       "dns_record_types": ["CNAME"],
       "cname_target": "api.vnsecurity.io",
       "ttl": 300,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    ('b0000001-0001-0001-0001-000000000008', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'v2.api.vnsecurity.io', 'domain', 'critical', 'active',
     'API v2 subdomain - Current version (Level 3)',
     'external', 'public', 55, 3,
     ARRAY['production', 'api', 'v2', 'current', 'sub-subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 3,
       "parent_domain": "api.vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "api_discovery",
       "dns_record_types": ["CNAME"],
       "cname_target": "api.vnsecurity.io",
       "ttl": 300,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '150 days', NOW(), NOW() - INTERVAL '150 days'),

    ('b0000001-0001-0001-0001-000000000009', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'api.staging.vnsecurity.io', 'domain', 'medium', 'active',
     'Staging API subdomain (Level 3)',
     'internal', 'restricted', 20, 0,
     ARRAY['staging', 'api', 'sub-subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 3,
       "parent_domain": "staging.vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "dns",
       "dns_record_types": ["A"],
       "resolved_ips": ["10.0.100.20"],
       "ttl": 60,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0001-0001-0001-000000000010', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'jenkins.dev.vnsecurity.io', 'domain', 'medium', 'active',
     'Jenkins CI/CD subdomain (Level 3)',
     'internal', 'private', 25, 1,
     ARRAY['development', 'ci-cd', 'jenkins', 'sub-subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 3,
       "parent_domain": "dev.vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "web_crawl",
       "dns_record_types": ["A"],
       "resolved_ips": ["10.0.200.50"],
       "ttl": 60,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '150 days', NOW(), NOW() - INTERVAL '150 days'),

    ('b0000001-0001-0001-0001-000000000011', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'grafana.dev.vnsecurity.io', 'domain', 'low', 'active',
     'Grafana monitoring subdomain (Level 3)',
     'internal', 'private', 20, 0,
     ARRAY['development', 'monitoring', 'grafana', 'sub-subdomain'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 3,
       "parent_domain": "dev.vnsecurity.io",
       "is_wildcard": false,
       "discovery_source": "bruteforce",
       "dns_record_types": ["A"],
       "resolved_ips": ["10.0.200.60"],
       "ttl": 60,
       "has_certificate": true
     }'::jsonb,
     NOW() - INTERVAL '120 days', NOW(), NOW() - INTERVAL '120 days'),

    -- Wildcard Domain
    ('b0000001-0001-0001-0001-000000000012', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '*.vnsecurity.io', 'domain', 'high', 'active',
     'Wildcard domain for all subdomains',
     'external', 'public', 35, 0,
     ARRAY['wildcard', 'production'],
     '{
       "root_domain": "vnsecurity.io",
       "domain_level": 2,
       "parent_domain": "vnsecurity.io",
       "is_wildcard": true,
       "discovery_source": "cert_transparency",
       "has_certificate": true,
       "certificate_asset_id": "b0000001-0002-0001-0001-000000000001"
     }'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    -- CERTIFICATES (certificate)
    ('b0000001-0002-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '*.vnsecurity.io Wildcard SSL', 'certificate', 'critical', 'active',
     'Wildcard SSL certificate for all subdomains',
     'external', 'public', 15, 0,
     ARRAY['ssl', 'wildcard', 'production'],
     '{"issuer": "Let''s Encrypt", "subject": "*.vnsecurity.io", "not_before": "2024-01-01", "not_after": "2025-01-01", "key_size": 2048, "signature_algorithm": "SHA256withRSA", "san": ["*.vnsecurity.io", "vnsecurity.io"]}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0002-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'api.vnsecurity.io EV SSL', 'certificate', 'critical', 'active',
     'Extended Validation SSL for API Gateway',
     'external', 'public', 10, 0,
     ARRAY['ssl', 'ev', 'api'],
     '{"issuer": "DigiCert", "subject": "api.vnsecurity.io", "not_before": "2024-06-01", "not_after": "2026-06-01", "key_size": 4096, "type": "EV"}'::jsonb,
     NOW() - INTERVAL '120 days', NOW(), NOW() - INTERVAL '120 days'),

    -- IP ADDRESSES (ip_address)
    ('b0000001-0003-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '103.45.67.10', 'ip_address', 'critical', 'active',
     'Primary load balancer public IP',
     'external', 'public', 50, 2,
     ARRAY['production', 'load-balancer', 'public'],
     '{"version": "ipv4", "asn": "AS45903", "asn_org": "VNPT", "country": "VN", "city": "Ho Chi Minh", "isp": "VNPT", "reverse_dns": "lb1.vnsecurity.io", "open_ports": [80, 443]}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0003-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '103.45.67.11', 'ip_address', 'critical', 'active',
     'Secondary load balancer public IP',
     'external', 'public', 50, 2,
     ARRAY['production', 'load-balancer', 'failover'],
     '{"version": "ipv4", "asn": "AS45903", "asn_org": "VNPT", "country": "VN", "city": "Ho Chi Minh", "reverse_dns": "lb2.vnsecurity.io", "open_ports": [80, 443]}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0003-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '10.0.1.100', 'ip_address', 'high', 'active',
     'Internal API Gateway IP',
     'internal', 'private', 25, 0,
     ARRAY['internal', 'api-gateway'],
     '{"version": "ipv4", "is_public": false, "subnet": "10.0.1.0/24"}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    -- =========================================================================
    -- 2. APPLICATIONS
    -- =========================================================================

    -- WEBSITES (website)
    ('b0000001-0004-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity Main Website', 'website', 'high', 'active',
     'Company main website - Corporate presence',
     'external', 'public', 30, 1,
     ARRAY['production', 'marketing', 'public'],
     '{"url": "https://vnsecurity.io", "technology": ["Next.js", "React", "Tailwind"], "ssl": true, "http_status": 200, "response_time_ms": 150, "server": "Vercel", "waf": "Cloudflare", "cdn": "Cloudflare"}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0004-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity Customer Portal', 'website', 'critical', 'active',
     'Customer-facing portal for security dashboard',
     'external', 'restricted', 55, 3,
     ARRAY['production', 'portal', 'customer-facing'],
     '{"url": "https://portal.vnsecurity.io", "technology": ["React", "TypeScript", "Material-UI"], "ssl": true, "auth_type": "oauth2", "http_status": 200}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    ('b0000001-0004-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity Admin Dashboard', 'website', 'critical', 'active',
     'Internal admin dashboard for security operations',
     'internal', 'private', 40, 2,
     ARRAY['internal', 'admin', 'operations'],
     '{"url": "https://admin.vnsecurity.io", "technology": ["Vue.js", "Vuetify"], "ssl": true, "auth_type": "sso"}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    -- APIS (api)
    ('b0000001-0005-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity REST API v1', 'api', 'critical', 'active',
     'Main REST API for security platform',
     'external', 'restricted', 60, 4,
     ARRAY['production', 'rest', 'v1'],
     '{"base_url": "https://api.vnsecurity.io/v1", "type": "rest", "version": "1.0.0", "auth_type": "jwt", "rate_limit": 1000, "endpoints": 45, "openapi_spec": true, "documentation_url": "https://docs.vnsecurity.io/api"}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0005-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity GraphQL API', 'api', 'high', 'active',
     'GraphQL API for advanced queries',
     'external', 'restricted', 45, 2,
     ARRAY['production', 'graphql'],
     '{"base_url": "https://api.vnsecurity.io/graphql", "type": "graphql", "auth_type": "jwt", "introspection": false}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    ('b0000001-0005-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Internal gRPC Service', 'api', 'high', 'active',
     'Internal microservices gRPC API',
     'internal', 'private', 25, 1,
     ARRAY['internal', 'grpc', 'microservices'],
     '{"type": "grpc", "port": 50051, "tls": true, "services": ["AuthService", "ScanService", "ReportService"]}'::jsonb,
     NOW() - INTERVAL '150 days', NOW(), NOW() - INTERVAL '150 days'),

    -- MOBILE APPS (mobile_app)
    ('b0000001-0006-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity Mobile (Android)', 'mobile_app', 'high', 'active',
     'Android mobile application for security alerts',
     'external', 'public', 35, 2,
     ARRAY['production', 'android', 'mobile'],
     '{"platform": "android", "bundle_id": "io.vnsecurity.mobile", "version": "2.5.0", "build": "125", "min_sdk": "26", "target_sdk": "34", "store_url": "https://play.google.com/store/apps/details?id=io.vnsecurity.mobile", "downloads": 50000, "rating": 4.5}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0006-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity Mobile (iOS)', 'mobile_app', 'high', 'active',
     'iOS mobile application for security alerts',
     'external', 'public', 35, 1,
     ARRAY['production', 'ios', 'mobile'],
     '{"platform": "ios", "bundle_id": "io.vnsecurity.mobile", "version": "2.5.0", "build": "125", "min_ios": "14.0", "store_url": "https://apps.apple.com/app/vnsecurity/id1234567890", "downloads": 25000, "rating": 4.6}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    -- SERVICES (service) - Network Services
    ('b0000001-0007-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'SSH Service (prod-web-01)', 'service', 'high', 'active',
     'SSH access on production web server',
     'internal', 'private', 40, 1,
     ARRAY['production', 'ssh', 'management'],
     '{"port": 22, "protocol": "tcp", "version": "OpenSSH_8.9p1", "host": "10.0.1.10", "auth_methods": ["publickey"]}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0007-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'HTTPS Service (Load Balancer)', 'service', 'critical', 'active',
     'HTTPS service on load balancer',
     'external', 'public', 30, 0,
     ARRAY['production', 'https', 'web'],
     '{"port": 443, "protocol": "tcp", "version": "nginx/1.24.0", "tls_version": "TLSv1.3", "host": "103.45.67.10"}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0007-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'PostgreSQL Service', 'service', 'critical', 'active',
     'PostgreSQL database service',
     'internal', 'private', 35, 1,
     ARRAY['production', 'database', 'postgresql'],
     '{"port": 5432, "protocol": "tcp", "version": "PostgreSQL 15.4", "host": "10.0.2.10", "ssl": true}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0007-0001-0001-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Redis Service', 'service', 'high', 'active',
     'Redis cache service',
     'internal', 'private', 25, 0,
     ARRAY['production', 'cache', 'redis'],
     '{"port": 6379, "protocol": "tcp", "version": "Redis 7.2", "host": "10.0.2.20", "auth": true}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    ('b0000001-0007-0001-0001-000000000005', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Elasticsearch Service', 'service', 'high', 'active',
     'Elasticsearch for log analysis',
     'internal', 'private', 30, 1,
     ARRAY['production', 'logging', 'elasticsearch'],
     '{"port": 9200, "protocol": "tcp", "version": "Elasticsearch 8.11", "host": "10.0.3.10", "cluster": "vnsec-logs"}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    -- =========================================================================
    -- 3. CLOUD
    -- =========================================================================

    -- CLOUD ACCOUNTS (cloud_account)
    ('b0000001-0008-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity AWS Production', 'cloud_account', 'critical', 'active',
     'Main AWS production account',
     'cloud', 'restricted', 45, 3,
     ARRAY['production', 'aws', 'primary'],
     '{"provider": "aws", "account_id": "123456789012", "alias": "vnsec-prod", "region": "ap-southeast-1", "organization_id": "o-abcd1234", "mfa_enabled": true, "sso_enabled": true, "monthly_spend": 15000, "resource_count": 250}'::jsonb,
     NOW() - INTERVAL '400 days', NOW(), NOW() - INTERVAL '400 days'),

    ('b0000001-0008-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity GCP Analytics', 'cloud_account', 'high', 'active',
     'GCP project for data analytics',
     'cloud', 'restricted', 30, 1,
     ARRAY['analytics', 'gcp'],
     '{"provider": "gcp", "project_id": "vnsec-analytics-prod", "organization_id": "123456789", "billing_account": "ABCD-1234", "region": "asia-southeast1"}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    -- COMPUTE (compute) - VMs/Instances
    ('b0000001-0009-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'prod-web-01 (EC2)', 'compute', 'critical', 'active',
     'Production web server instance 1',
     'cloud', 'restricted', 50, 2,
     ARRAY['production', 'web', 'ec2'],
     '{"provider": "aws", "instance_id": "i-0abc123def456789", "instance_type": "m5.xlarge", "state": "running", "availability_zone": "ap-southeast-1a", "vpc_id": "vpc-12345678", "private_ip": "10.0.1.10", "public_ip": "103.45.67.10", "security_groups": ["sg-web-prod"], "iam_role": "ec2-web-role"}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0009-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'prod-web-02 (EC2)', 'compute', 'critical', 'active',
     'Production web server instance 2',
     'cloud', 'restricted', 50, 2,
     ARRAY['production', 'web', 'ec2'],
     '{"provider": "aws", "instance_id": "i-0def789abc123456", "instance_type": "m5.xlarge", "state": "running", "availability_zone": "ap-southeast-1b", "vpc_id": "vpc-12345678", "private_ip": "10.0.1.11", "public_ip": "103.45.67.11"}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0009-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'prod-api-01 (EC2)', 'compute', 'critical', 'active',
     'Production API server instance',
     'cloud', 'private', 45, 1,
     ARRAY['production', 'api', 'ec2'],
     '{"provider": "aws", "instance_id": "i-0ghi456jkl789012", "instance_type": "c5.2xlarge", "state": "running", "availability_zone": "ap-southeast-1a", "private_ip": "10.0.1.20"}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    -- STORAGE (storage) - S3/Blob
    ('b0000001-0010-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-prod-data (S3)', 'storage', 'critical', 'active',
     'Production data storage bucket',
     'cloud', 'private', 40, 2,
     ARRAY['production', 's3', 'data'],
     '{"provider": "aws", "bucket_name": "vnsec-prod-data", "region": "ap-southeast-1", "storage_class": "STANDARD", "versioning": true, "encryption": "AES256", "public_access": false, "logging": true, "object_count": 1500000, "total_size_gb": 500}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0010-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-logs (S3)', 'storage', 'high', 'active',
     'Log archive storage bucket',
     'cloud', 'private', 25, 0,
     ARRAY['production', 's3', 'logs'],
     '{"provider": "aws", "bucket_name": "vnsec-logs", "region": "ap-southeast-1", "storage_class": "GLACIER", "versioning": false, "encryption": "AES256", "lifecycle_rules": 3, "retention_days": 365}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0010-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-public-assets (S3)', 'storage', 'medium', 'active',
     'Public static assets CDN origin',
     'cloud', 'public', 20, 1,
     ARRAY['production', 's3', 'cdn', 'public'],
     '{"provider": "aws", "bucket_name": "vnsec-public-assets", "region": "ap-southeast-1", "public_access": true, "cdn": "CloudFront", "total_size_gb": 50}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    -- SERVERLESS (serverless) - Lambda/Functions
    ('b0000001-0011-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'scan-processor (Lambda)', 'serverless', 'critical', 'active',
     'Vulnerability scan processor function',
     'cloud', 'private', 45, 2,
     ARRAY['production', 'lambda', 'scanner'],
     '{"provider": "aws", "function_name": "vnsec-scan-processor", "runtime": "python3.11", "memory": 1024, "timeout": 300, "handler": "handler.main", "triggers": ["SQS", "EventBridge"], "env_vars": 5, "vpc_enabled": true}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    ('b0000001-0011-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'alert-notifier (Lambda)', 'serverless', 'high', 'active',
     'Alert notification function',
     'cloud', 'private', 30, 1,
     ARRAY['production', 'lambda', 'notifications'],
     '{"provider": "aws", "function_name": "vnsec-alert-notifier", "runtime": "nodejs20.x", "memory": 256, "timeout": 30, "triggers": ["SNS", "EventBridge"]}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0011-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'report-generator (Lambda)', 'serverless', 'high', 'active',
     'Report PDF generator function',
     'cloud', 'private', 25, 0,
     ARRAY['production', 'lambda', 'reports'],
     '{"provider": "aws", "function_name": "vnsec-report-generator", "runtime": "python3.11", "memory": 2048, "timeout": 900, "triggers": ["API Gateway", "S3"]}'::jsonb,
     NOW() - INTERVAL '150 days', NOW(), NOW() - INTERVAL '150 days'),

    -- =========================================================================
    -- 4. INFRASTRUCTURE
    -- =========================================================================

    -- HOSTS (host) - Physical/Virtual Servers
    ('b0000001-0012-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'pentest-kali-01', 'host', 'medium', 'active',
     'Kali Linux pentest workstation',
     'internal', 'isolated', 15, 0,
     ARRAY['tools', 'pentest', 'kali'],
     '{"ip": "192.168.100.10", "hostname": "pentest-kali-01.internal", "os": "Kali Linux", "os_version": "2024.1", "architecture": "x64", "cpu_cores": 8, "memory_gb": 32, "is_virtual": true}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0012-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'bastion-host-01', 'host', 'critical', 'active',
     'Production bastion/jump host',
     'cloud', 'restricted', 55, 2,
     ARRAY['production', 'bastion', 'management'],
     '{"ip": "10.0.0.5", "hostname": "bastion-01.vnsecurity.io", "os": "Ubuntu", "os_version": "22.04 LTS", "open_ports": [22], "hardened": true}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0012-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'monitoring-server', 'host', 'high', 'active',
     'Monitoring and observability server',
     'internal', 'private', 30, 1,
     ARRAY['monitoring', 'prometheus', 'grafana'],
     '{"ip": "10.0.5.10", "hostname": "monitoring.internal", "os": "Ubuntu", "os_version": "22.04 LTS", "services": ["prometheus", "grafana", "alertmanager"]}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    -- CONTAINERS (container)
    ('b0000001-0013-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-api (Deployment)', 'container', 'critical', 'active',
     'Main API deployment in Kubernetes',
     'cloud', 'private', 45, 2,
     ARRAY['production', 'kubernetes', 'api'],
     '{"image": "vnsecurity/api:v2.5.0", "registry": "ecr.aws", "runtime": "containerd", "orchestrator": "kubernetes", "namespace": "production", "cluster": "vnsec-eks-prod", "replicas": 3, "cpu_limit": "2", "memory_limit": "4Gi"}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    ('b0000001-0013-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-scanner (Deployment)', 'container', 'critical', 'active',
     'Vulnerability scanner deployment',
     'cloud', 'private', 50, 3,
     ARRAY['production', 'kubernetes', 'scanner'],
     '{"image": "vnsecurity/scanner:v1.8.0", "registry": "ecr.aws", "orchestrator": "kubernetes", "namespace": "production", "replicas": 5, "cpu_limit": "4", "memory_limit": "8Gi"}'::jsonb,
     NOW() - INTERVAL '180 days', NOW(), NOW() - INTERVAL '180 days'),

    ('b0000001-0013-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'redis-cluster (StatefulSet)', 'container', 'high', 'active',
     'Redis cluster for caching',
     'cloud', 'private', 30, 0,
     ARRAY['production', 'kubernetes', 'redis'],
     '{"image": "redis:7.2-alpine", "registry": "docker.io", "orchestrator": "kubernetes", "namespace": "production", "replicas": 3, "type": "statefulset"}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    -- DATABASES (database)
    ('b0000001-0014-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-prod-db (RDS PostgreSQL)', 'database', 'critical', 'active',
     'Main production PostgreSQL database',
     'cloud', 'private', 55, 2,
     ARRAY['production', 'rds', 'postgresql'],
     '{"engine": "postgresql", "version": "15.4", "host": "vnsec-prod.xxx.ap-southeast-1.rds.amazonaws.com", "port": 5432, "size_gb": 500, "encryption": true, "backup_enabled": true, "backup_retention": 30, "multi_az": true, "replication": "replica-set", "connections": 150}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0014-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-analytics-db (RDS PostgreSQL)', 'database', 'high', 'active',
     'Analytics data warehouse',
     'cloud', 'private', 35, 1,
     ARRAY['analytics', 'rds', 'postgresql'],
     '{"engine": "postgresql", "version": "15.4", "host": "vnsec-analytics.xxx.ap-southeast-1.rds.amazonaws.com", "port": 5432, "size_gb": 1000, "encryption": true, "backup_enabled": true}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0014-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-cache (ElastiCache Redis)', 'database', 'high', 'active',
     'Redis cache cluster',
     'cloud', 'private', 25, 0,
     ARRAY['production', 'elasticache', 'redis'],
     '{"engine": "redis", "version": "7.0", "host": "vnsec-cache.xxx.cache.amazonaws.com", "port": 6379, "encryption": true, "node_type": "cache.r6g.large", "replicas": 2}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    ('b0000001-0014-0001-0001-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-logs-db (OpenSearch)', 'database', 'high', 'active',
     'OpenSearch cluster for log storage',
     'cloud', 'private', 30, 1,
     ARRAY['production', 'opensearch', 'logging'],
     '{"engine": "elasticsearch", "version": "OpenSearch 2.11", "host": "vnsec-logs.xxx.es.amazonaws.com", "port": 443, "encryption": true, "node_count": 3}'::jsonb,
     NOW() - INTERVAL '200 days', NOW(), NOW() - INTERVAL '200 days'),

    -- NETWORK (network) - VPCs, Firewalls, Load Balancers
    ('b0000001-0015-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-prod-vpc', 'network', 'critical', 'active',
     'Production VPC',
     'cloud', 'private', 40, 1,
     ARRAY['production', 'vpc', 'aws'],
     '{"type": "vpc", "vpc_id": "vpc-12345678", "cidr": "10.0.0.0/16", "subnets": ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], "region": "ap-southeast-1", "flow_logs": true, "nat_gateways": 2}'::jsonb,
     NOW() - INTERVAL '400 days', NOW(), NOW() - INTERVAL '400 days'),

    ('b0000001-0015-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-prod-alb', 'network', 'critical', 'active',
     'Production Application Load Balancer',
     'cloud', 'public', 45, 1,
     ARRAY['production', 'alb', 'load-balancer'],
     '{"type": "load_balancer", "lb_type": "application", "scheme": "internet-facing", "dns": "vnsec-prod-alb-xxx.ap-southeast-1.elb.amazonaws.com", "target_groups": 3, "listeners": 2, "health_check": true}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    ('b0000001-0015-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-waf', 'network', 'critical', 'active',
     'AWS WAF for API protection',
     'cloud', 'public', 35, 0,
     ARRAY['production', 'waf', 'security'],
     '{"type": "firewall", "provider": "aws_waf", "rules": 15, "managed_rules": ["AWSManagedRulesCommonRuleSet", "AWSManagedRulesSQLiRuleSet", "AWSManagedRulesKnownBadInputsRuleSet"]}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0015-0001-0001-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-vpn', 'network', 'high', 'active',
     'Site-to-Site VPN to office',
     'cloud', 'private', 30, 0,
     ARRAY['production', 'vpn', 'connectivity'],
     '{"type": "vpn", "vpn_type": "site-to-site", "customer_gateway": "cgw-12345678", "tunnel_count": 2, "encryption": "AES256"}'::jsonb,
     NOW() - INTERVAL '350 days', NOW(), NOW() - INTERVAL '350 days'),

    -- =========================================================================
    -- 5. CODE & CI/CD
    -- =========================================================================

    -- PROJECTS (project) - Source Code
    ('b0000001-0016-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-platform', 'project', 'critical', 'active',
     'Main platform monorepo',
     'internal', 'private', 55, 5,
     ARRAY['production', 'monorepo', 'core'],
     '{"provider": "github", "visibility": "private", "language": "Go", "languages": {"Go": 60, "TypeScript": 30, "Python": 10}, "default_branch": "main", "stars": 0, "contributors": 12, "branch_protection": true, "secret_scanning": true, "dependabot": true}'::jsonb,
     NOW() - INTERVAL '500 days', NOW(), NOW() - INTERVAL '500 days'),

    ('b0000001-0016-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-scanner-engine', 'project', 'critical', 'active',
     'Vulnerability scanner engine',
     'internal', 'private', 50, 3,
     ARRAY['production', 'scanner', 'core'],
     '{"provider": "github", "visibility": "private", "language": "Python", "default_branch": "main", "contributors": 5, "branch_protection": true}'::jsonb,
     NOW() - INTERVAL '400 days', NOW(), NOW() - INTERVAL '400 days'),

    ('b0000001-0016-0001-0001-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-infrastructure', 'project', 'high', 'active',
     'Infrastructure as Code repository',
     'internal', 'private', 40, 2,
     ARRAY['infrastructure', 'terraform', 'iac'],
     '{"provider": "github", "visibility": "private", "language": "HCL", "default_branch": "main", "contributors": 3, "branch_protection": true}'::jsonb,
     NOW() - INTERVAL '350 days', NOW(), NOW() - INTERVAL '350 days'),

    ('b0000001-0016-0001-0001-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'vnsec-docs', 'project', 'low', 'active',
     'Public documentation site',
     'external', 'public', 10, 0,
     ARRAY['documentation', 'public'],
     '{"provider": "github", "visibility": "public", "language": "Markdown", "default_branch": "main", "stars": 45}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    -- =========================================================================
    -- 6. OTHER TYPES
    -- =========================================================================

    -- SERVER (server)
    ('b0000001-0017-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'mail-server-01', 'server', 'high', 'active',
     'Corporate mail server',
     'internal', 'restricted', 40, 1,
     ARRAY['production', 'mail', 'exchange'],
     '{"hostname": "mail.vnsecurity.io", "ip": "10.0.10.10", "os": "Windows Server 2022", "role": "mail_server", "services": ["SMTP", "IMAP", "Exchange"]}'::jsonb,
     NOW() - INTERVAL '400 days', NOW(), NOW() - INTERVAL '400 days'),

    -- APPLICATION (application)
    ('b0000001-0018-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity SIEM', 'application', 'critical', 'active',
     'Security Information and Event Management',
     'internal', 'private', 35, 1,
     ARRAY['security', 'siem', 'monitoring'],
     '{"vendor": "Splunk", "version": "9.1", "type": "enterprise", "data_sources": 25, "alerts_configured": 150}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0018-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'VNSecurity EDR', 'application', 'critical', 'active',
     'Endpoint Detection and Response',
     'internal', 'private', 30, 0,
     ARRAY['security', 'edr', 'endpoint'],
     '{"vendor": "CrowdStrike", "version": "Falcon", "endpoints_protected": 500, "policies": 12}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    -- ENDPOINT (endpoint)
    ('b0000001-0019-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '/api/v1/auth/login', 'endpoint', 'critical', 'active',
     'Authentication login endpoint',
     'external', 'public', 60, 2,
     ARRAY['auth', 'public', 'critical'],
     '{"method": "POST", "path": "/api/v1/auth/login", "rate_limit": 10, "auth_required": false}'::jsonb,
     NOW() - INTERVAL '300 days', NOW(), NOW() - INTERVAL '300 days'),

    ('b0000001-0019-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '/api/v1/scans', 'endpoint', 'high', 'active',
     'Vulnerability scans endpoint',
     'external', 'restricted', 45, 1,
     ARRAY['scans', 'api'],
     '{"method": "GET,POST", "path": "/api/v1/scans", "rate_limit": 100, "auth_required": true}'::jsonb,
     NOW() - INTERVAL '250 days', NOW(), NOW() - INTERVAL '250 days'),

    -- CLOUD (cloud) - Generic cloud resource
    ('b0000001-0020-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'CloudFlare CDN', 'cloud', 'high', 'active',
     'CloudFlare CDN and DDoS protection',
     'external', 'public', 25, 0,
     ARRAY['cdn', 'cloudflare', 'ddos-protection'],
     '{"provider": "cloudflare", "zone": "vnsecurity.io", "plan": "enterprise", "features": ["CDN", "WAF", "DDoS", "Bot Management"]}'::jsonb,
     NOW() - INTERVAL '365 days', NOW(), NOW() - INTERVAL '365 days'),

    -- OTHER (other)
    ('b0000001-0021-0001-0001-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'HSM Device', 'other', 'critical', 'active',
     'Hardware Security Module for key management',
     'internal', 'isolated', 20, 0,
     ARRAY['security', 'hsm', 'keys'],
     '{"vendor": "Thales", "model": "Luna Network HSM 7", "location": "DC1-Rack-15", "fips_level": "140-2 Level 3"}'::jsonb,
     NOW() - INTERVAL '400 days', NOW(), NOW() - INTERVAL '400 days'),

    ('b0000001-0021-0001-0001-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Backup Tape Library', 'other', 'high', 'active',
     'Offline backup tape storage',
     'internal', 'isolated', 15, 0,
     ARRAY['backup', 'tape', 'disaster-recovery'],
     '{"vendor": "Dell", "model": "PowerVault TL2000", "capacity_tb": 100, "location": "DC1-Rack-20"}'::jsonb,
     NOW() - INTERVAL '500 days', NOW(), NOW() - INTERVAL '500 days')

ON CONFLICT (tenant_id, name) DO UPDATE SET
    asset_type = EXCLUDED.asset_type,
    description = EXCLUDED.description,
    criticality = EXCLUDED.criticality,
    status = EXCLUDED.status,
    scope = EXCLUDED.scope,
    exposure = EXCLUDED.exposure,
    risk_score = EXCLUDED.risk_score,
    finding_count = EXCLUDED.finding_count,
    tags = EXCLUDED.tags,
    metadata = EXCLUDED.metadata,
    last_seen = NOW(),
    updated_at = NOW();

-- Reset RLS setting
RESET app.current_tenant;

-- =============================================================================
-- Seed Data Summary for VN Security Team
-- =============================================================================
-- Total Assets: 63
--
-- By Type:
--   - domain: 12 (with hierarchy: 1 root, 6 level-2, 5 level-3, 1 wildcard)
--   - certificate: 2
--   - ip_address: 3
--   - website: 3
--   - api: 3
--   - mobile_app: 2
--   - service: 5
--   - cloud_account: 2
--   - compute: 3
--   - storage: 3
--   - serverless: 3
--   - host: 3
--   - container: 3
--   - database: 4
--   - network: 4
--   - project: 4
--   - server: 1
--   - application: 2
--   - endpoint: 2
--   - cloud: 1
--   - other: 2
--
-- Domain Hierarchy Structure:
--   vnsecurity.io (level 1 - root)
--   +-- api.vnsecurity.io (level 2)
--   |   +-- v1.api.vnsecurity.io (level 3)
--   |   +-- v2.api.vnsecurity.io (level 3)
--   +-- portal.vnsecurity.io (level 2)
--   +-- staging.vnsecurity.io (level 2)
--   |   +-- api.staging.vnsecurity.io (level 3)
--   +-- dev.vnsecurity.io (level 2)
--   |   +-- jenkins.dev.vnsecurity.io (level 3)
--   |   +-- grafana.dev.vnsecurity.io (level 3)
--   +-- mail.vnsecurity.io (level 2)
--   +-- *.vnsecurity.io (wildcard)
--
-- Domain Metadata Fields (Best Practice):
--   - root_domain: Root/apex domain for grouping
--   - domain_level: 1=root, 2=subdomain, 3=sub-subdomain, etc.
--   - parent_domain: Immediate parent domain
--   - is_wildcard: Wildcard domain flag
--   - discovery_source: dns, cert_transparency, bruteforce, passive, manual, api_discovery, web_crawl
--   - dns_record_types: A, AAAA, CNAME, MX, NS, TXT, etc.
--   - resolved_ips: IP addresses
--   - nameservers, mx_records, cname_target, ttl
--   - dnssec_enabled, spf, dkim, dmarc, caa
--   - has_certificate, certificate_asset_id
--
-- By Criticality:
--   - critical: 27
--   - high: 22
--   - medium: 8
--   - low: 6
--
-- By Exposure:
--   - public: 14
--   - restricted: 12
--   - private: 32
--   - isolated: 5
-- =============================================================================
