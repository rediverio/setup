-- =============================================================================
-- Test/Development Seed Data for Rediver Platform
-- =============================================================================
-- Vietnamese company mock data for development and testing
-- DO NOT run this in production environments!
-- =============================================================================
-- Usage: make docker-seed-test
-- =============================================================================

-- Disable RLS for seeding
SET app.current_tenant = '';

-- =============================================================================
-- 1. USERS
-- Password for all seed users: Password123
-- Hash: $2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG
-- =============================================================================
INSERT INTO users (id, email, name, avatar_url, status, password_hash, email_verified, auth_provider, created_at)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'admin@rediver.io', 'Admin User', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW()),
    ('22222222-2222-2222-2222-222222222222', 'nguyen.an@techviet.vn', 'Nguyen Van An', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW()),
    ('33333333-3333-3333-3333-333333333333', 'tran.binh@techviet.vn', 'Tran Thi Binh', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW()),
    ('44444444-4444-4444-4444-444444444444', 'le.cuong@techviet.vn', 'Le Van Cuong', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW()),
    ('55555555-5555-5555-5555-555555555555', 'pham.dung@techviet.vn', 'Pham Thi Dung', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW()),
    ('66666666-6666-6666-6666-666666666666', 'hoang.em@techviet.vn', 'Hoang Van Em', NULL, 'active', '$2a$12$lAqs23AmzWlMNDCUaUuuceAWEw/EzF25N/oLnSfa1gUldIRllsqHG', true, 'local', NOW())
ON CONFLICT (id) DO UPDATE SET
    password_hash = EXCLUDED.password_hash,
    email_verified = EXCLUDED.email_verified,
    auth_provider = EXCLUDED.auth_provider;

-- =============================================================================
-- 2. TENANTS (Teams)
-- =============================================================================
INSERT INTO tenants (id, name, slug, description, plan, created_by, created_at)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'TechViet Solutions', 'techviet', 'Cong ty phat trien phan mem TechViet', 'pro', '11111111-1111-1111-1111-111111111111', NOW()),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'VN Security Team', 'vnsecurity', 'Doi bao mat mang Viet Nam', 'enterprise', '11111111-1111-1111-1111-111111111111', NOW()),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Startup Hub', 'startup-hub', 'Cong dong startup cong nghe', 'free', '22222222-2222-2222-2222-222222222222', NOW())
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 3. TENANT MEMBERS
-- =============================================================================
INSERT INTO tenant_members (id, user_id, tenant_id, role, joined_at)
VALUES
    -- TechViet Solutions members
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'owner', NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'admin', NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'member', NOW()),
    (gen_random_uuid(), '44444444-4444-4444-4444-444444444444', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'member', NOW()),
    -- VN Security Team members
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'owner', NOW()),
    (gen_random_uuid(), '55555555-5555-5555-5555-555555555555', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'admin', NOW()),
    (gen_random_uuid(), '66666666-6666-6666-6666-666666666666', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'member', NOW()),
    -- Startup Hub members
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'owner', NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'member', NOW())
ON CONFLICT DO NOTHING;

-- =============================================================================
-- 4. ASSETS
-- =============================================================================
INSERT INTO assets (id, tenant_id, name, asset_type, criticality, status, description, tags, metadata, created_at)
VALUES
    -- TechViet Assets
    ('a1000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet.vn', 'domain', 'critical', 'active', 'Main company domain', ARRAY['production', 'public'], '{"registrar": "VNNIC", "expiry": "2025-12-31"}', NOW() - INTERVAL '30 days'),
    ('a1000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'api.techviet.vn', 'domain', 'high', 'active', 'API subdomain', ARRAY['production', 'api'], '{"ssl": true}', NOW() - INTERVAL '25 days'),
    ('a1000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'staging.techviet.vn', 'domain', 'medium', 'active', 'Staging environment', ARRAY['staging'], '{}', NOW() - INTERVAL '20 days'),
    ('a1000004-0000-0000-0000-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'prod-web-01', 'host', 'critical', 'active', 'Production web server 1', ARRAY['production', 'web'], '{"ip": "10.0.1.10", "os": "Ubuntu 22.04"}', NOW() - INTERVAL '60 days'),
    ('a1000005-0000-0000-0000-000000000005', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'prod-web-02', 'host', 'critical', 'active', 'Production web server 2', ARRAY['production', 'web'], '{"ip": "10.0.1.11", "os": "Ubuntu 22.04"}', NOW() - INTERVAL '60 days'),
    ('a1000006-0000-0000-0000-000000000006', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'prod-db-master', 'host', 'critical', 'active', 'Production database master', ARRAY['production', 'database'], '{"ip": "10.0.2.10", "os": "Ubuntu 22.04"}', NOW() - INTERVAL '90 days'),
    ('a1000007-0000-0000-0000-000000000007', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-postgres', 'database', 'critical', 'active', 'Main PostgreSQL database', ARRAY['production'], '{"engine": "postgresql", "version": "15.4"}', NOW() - INTERVAL '90 days'),
    ('a1000008-0000-0000-0000-000000000008', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-redis', 'database', 'high', 'active', 'Redis cache cluster', ARRAY['production', 'cache'], '{"engine": "redis", "version": "7.2"}', NOW() - INTERVAL '45 days'),
    ('a1000009-0000-0000-0000-000000000009', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-k8s', 'container', 'critical', 'active', 'Kubernetes cluster', ARRAY['production', 'k8s'], '{"provider": "eks", "version": "1.28"}', NOW() - INTERVAL '120 days'),
    ('a1000010-0000-0000-0000-000000000010', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-aws', 'cloud', 'critical', 'active', 'AWS Production Account', ARRAY['production', 'aws'], '{"account_id": "123456789012", "region": "ap-southeast-1"}', NOW() - INTERVAL '180 days'),

    -- VN Security Assets
    ('a2000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'vnsecurity.io', 'domain', 'critical', 'active', 'Security team domain', ARRAY['production'], '{}', NOW() - INTERVAL '15 days'),
    ('a2000002-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'scanner.vnsecurity.io', 'domain', 'high', 'active', 'Vulnerability scanner', ARRAY['tools'], '{}', NOW() - INTERVAL '10 days'),
    ('a2000003-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pentest-vm-01', 'host', 'medium', 'active', 'Pentest workstation', ARRAY['tools', 'kali'], '{"os": "Kali Linux"}', NOW() - INTERVAL '7 days'),

    -- Startup Hub Assets
    ('a3000001-0000-0000-0000-000000000001', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'startuphub.vn', 'domain', 'high', 'active', 'Startup community domain', ARRAY['production'], '{}', NOW() - INTERVAL '5 days'),
    ('a3000002-0000-0000-0000-000000000002', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'demo.startuphub.vn', 'domain', 'low', 'active', 'Demo environment', ARRAY['demo'], '{}', NOW() - INTERVAL '3 days')
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 5. PROJECTS
-- =============================================================================
INSERT INTO projects (id, tenant_id, name, full_name, description, provider, visibility, default_branch, language, status, scope, exposure, tags, created_at)
VALUES
    -- TechViet Projects
    ('01000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-backend', 'techviet/techviet-backend', 'Main backend API service', 'github', 'private', 'main', 'Go', 'active', 'internal', 'internal', ARRAY['backend', 'api', 'go'], NOW() - INTERVAL '180 days'),
    ('01000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-frontend', 'techviet/techviet-frontend', 'React frontend application', 'github', 'private', 'main', 'TypeScript', 'active', 'internal', 'internal', ARRAY['frontend', 'react', 'typescript'], NOW() - INTERVAL '180 days'),
    ('01000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-mobile', 'techviet/techviet-mobile', 'Mobile app (iOS/Android)', 'github', 'private', 'main', 'Dart', 'active', 'internal', 'internal', ARRAY['mobile', 'flutter'], NOW() - INTERVAL '120 days'),
    ('01000004-0000-0000-0000-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-infra', 'techviet/techviet-infra', 'Infrastructure as Code', 'github', 'private', 'main', 'HCL', 'active', 'internal', 'internal', ARRAY['infra', 'terraform', 'iac'], NOW() - INTERVAL '150 days'),
    ('01000005-0000-0000-0000-000000000005', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'techviet-docs', 'techviet/techviet-docs', 'Documentation site', 'github', 'public', 'main', 'Markdown', 'active', 'external', 'internet', ARRAY['docs', 'public'], NOW() - INTERVAL '90 days'),

    -- VN Security Projects
    ('02000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'vuln-scanner', 'vnsecurity/vuln-scanner', 'Custom vulnerability scanner', 'gitlab', 'private', 'main', 'Python', 'active', 'internal', 'internal', ARRAY['security', 'scanner', 'python'], NOW() - INTERVAL '60 days'),
    ('02000002-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'security-tools', 'vnsecurity/security-tools', 'Collection of security tools', 'gitlab', 'private', 'main', 'Python', 'active', 'internal', 'internal', ARRAY['security', 'tools'], NOW() - INTERVAL '45 days'),

    -- Startup Hub Projects
    ('03000001-0000-0000-0000-000000000001', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'startup-landing', 'startuphub/startup-landing', 'Landing page website', 'github', 'public', 'main', 'JavaScript', 'active', 'external', 'internet', ARRAY['landing', 'web'], NOW() - INTERVAL '30 days')
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 6. COMPONENTS
-- =============================================================================
INSERT INTO components (id, tenant_id, project_id, name, version, ecosystem, package_manager, dependency_type, license, status, created_at)
VALUES
    -- TechViet Backend Components
    ('c1000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000001-0000-0000-0000-000000000001', 'github.com/gin-gonic/gin', 'v1.9.1', 'go', 'go', 'direct', 'MIT', 'active', NOW()),
    ('c1000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000001-0000-0000-0000-000000000001', 'github.com/lib/pq', 'v1.10.9', 'go', 'go', 'direct', 'MIT', 'active', NOW()),
    ('c1000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000001-0000-0000-0000-000000000001', 'github.com/redis/go-redis/v9', 'v9.3.0', 'go', 'go', 'direct', 'BSD-2-Clause', 'active', NOW()),
    ('c1000004-0000-0000-0000-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000001-0000-0000-0000-000000000001', 'golang.org/x/crypto', 'v0.16.0', 'go', 'go', 'transitive', 'BSD-3-Clause', 'active', NOW()),

    -- TechViet Frontend Components
    ('c1000010-0000-0000-0000-000000000010', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000002-0000-0000-0000-000000000002', 'react', '18.2.0', 'npm', 'npm', 'direct', 'MIT', 'active', NOW()),
    ('c1000011-0000-0000-0000-000000000011', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000002-0000-0000-0000-000000000002', 'next', '14.0.4', 'npm', 'npm', 'direct', 'MIT', 'active', NOW()),
    ('c1000012-0000-0000-0000-000000000012', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000002-0000-0000-0000-000000000002', 'axios', '1.6.2', 'npm', 'npm', 'direct', 'MIT', 'active', NOW()),
    ('c1000013-0000-0000-0000-000000000013', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000002-0000-0000-0000-000000000002', 'lodash', '4.17.21', 'npm', 'npm', 'transitive', 'MIT', 'active', NOW()),

    -- TechViet Infra Components
    ('c1000020-0000-0000-0000-000000000020', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000004-0000-0000-0000-000000000004', 'hashicorp/aws', '5.31.0', 'other', 'terraform', 'direct', 'MPL-2.0', 'active', NOW()),
    ('c1000021-0000-0000-0000-000000000021', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '01000004-0000-0000-0000-000000000004', 'hashicorp/kubernetes', '2.24.0', 'other', 'terraform', 'direct', 'MPL-2.0', 'active', NOW()),

    -- VN Security Components
    ('c2000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '02000001-0000-0000-0000-000000000001', 'requests', '2.31.0', 'pypi', 'pip', 'direct', 'Apache-2.0', 'active', NOW()),
    ('c2000002-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '02000001-0000-0000-0000-000000000001', 'beautifulsoup4', '4.12.2', 'pypi', 'pip', 'direct', 'MIT', 'active', NOW()),
    ('c2000003-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '02000001-0000-0000-0000-000000000001', 'cryptography', '41.0.7', 'pypi', 'pip', 'direct', 'Apache-2.0', 'active', NOW())
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 7. VULNERABILITIES (Global CVE Catalog)
-- =============================================================================
INSERT INTO vulnerabilities (id, cve_id, title, description, severity, cvss_score, cvss_vector, exploit_available, exploit_maturity, published_at, status, created_at)
VALUES
    ('00000001-0000-0000-0000-000000000001', 'CVE-2023-44487', 'HTTP/2 Rapid Reset Attack', 'The HTTP/2 protocol allows a denial of service (server resource consumption) because request cancellation can reset many streams quickly.', 'high', 7.5, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H', true, 'weaponized', '2023-10-10', 'open', NOW()),
    ('00000002-0000-0000-0000-000000000002', 'CVE-2023-45853', 'zlib Heap Buffer Overflow', 'MiniZip in zlib through 1.3 has an integer overflow and resultant heap-based buffer overflow in zipOpenNewFileInZip4_64.', 'critical', 9.8, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H', true, 'poc', '2023-10-14', 'open', NOW()),
    ('00000003-0000-0000-0000-000000000003', 'CVE-2023-5217', 'libvpx Heap Buffer Overflow', 'Heap buffer overflow in vp8 encoding in libvpx in Google Chrome prior to 117.0.5938.132 allowed a remote attacker to potentially exploit heap corruption.', 'high', 8.8, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:H', true, 'weaponized', '2023-09-27', 'open', NOW()),
    ('00000004-0000-0000-0000-000000000004', 'CVE-2023-4863', 'libwebp Heap Buffer Overflow', 'Heap buffer overflow in WebP in Google Chrome prior to 116.0.5845.187 allowed a remote attacker to perform an out of bounds memory write.', 'critical', 9.6, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:H/I:H/A:H', true, 'weaponized', '2023-09-11', 'open', NOW()),
    ('00000005-0000-0000-0000-000000000005', 'CVE-2023-38545', 'curl SOCKS5 Heap Overflow', 'This flaw makes curl overflow a heap based buffer in the SOCKS5 proxy handshake.', 'critical', 9.8, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H', true, 'poc', '2023-10-11', 'open', NOW()),
    ('00000006-0000-0000-0000-000000000006', 'CVE-2023-36884', 'Microsoft Office RCE', 'Microsoft is investigating reports of a series of remote code execution vulnerabilities impacting Windows and Office products.', 'high', 8.3, 'CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:C/C:H/I:H/A:H', true, 'weaponized', '2023-07-11', 'open', NOW()),
    ('00000007-0000-0000-0000-000000000007', 'CVE-2023-20198', 'Cisco IOS XE Web UI RCE', 'Cisco is aware of active exploitation of a previously unknown vulnerability in the web UI feature of Cisco IOS XE Software.', 'critical', 10.0, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:H', true, 'weaponized', '2023-10-16', 'open', NOW()),
    ('00000008-0000-0000-0000-000000000008', 'CVE-2023-46747', 'F5 BIG-IP Configuration Utility RCE', 'Undisclosed requests may bypass configuration utility authentication, allowing an attacker with network access to execute arbitrary system commands.', 'critical', 9.8, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H', true, 'weaponized', '2023-10-26', 'open', NOW()),
    ('00000009-0000-0000-0000-000000000009', 'CVE-2023-22515', 'Atlassian Confluence Privilege Escalation', 'Atlassian has been made aware of an issue reported by a handful of customers where external attackers may have exploited a previously unknown vulnerability in publicly accessible Confluence instances.', 'critical', 10.0, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:H', true, 'weaponized', '2023-10-04', 'open', NOW()),
    ('00000010-0000-0000-0000-000000000010', 'CVE-2023-34362', 'MOVEit Transfer SQL Injection', 'In Progress MOVEit Transfer before 2021.0.6, 2021.1.4, 2022.0.4, 2022.1.5, and 2023.0.1, a SQL injection vulnerability has been found.', 'critical', 9.8, 'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H', true, 'weaponized', '2023-06-02', 'open', NOW()),
    ('00000011-0000-0000-0000-000000000011', 'CVE-2024-0001', 'Sample Low Severity Issue', 'A low severity information disclosure vulnerability exists in the application.', 'low', 3.1, 'CVSS:3.1/AV:N/AC:H/PR:L/UI:N/S:U/C:L/I:N/A:N', false, 'none', '2024-01-01', 'open', NOW()),
    ('00000012-0000-0000-0000-000000000012', 'CVE-2024-0002', 'Sample Medium Severity Issue', 'A medium severity cross-site scripting vulnerability allows attackers to inject scripts.', 'medium', 5.4, 'CVSS:3.1/AV:N/AC:L/PR:L/UI:R/S:C/C:L/I:L/A:N', true, 'poc', '2024-01-02', 'open', NOW())
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 8. FINDINGS (Vulnerability Instances)
-- =============================================================================
INSERT INTO findings (id, tenant_id, vulnerability_id, project_id, component_id, source, tool_name, message, severity, status, fingerprint, created_at)
VALUES
    -- TechViet Backend Findings
    ('f1000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000001-0000-0000-0000-000000000001', '01000001-0000-0000-0000-000000000001', NULL, 'sast', 'gosec', 'HTTP/2 Rapid Reset vulnerability detected in HTTP server configuration', 'high', 'open', 'fp-techviet-backend-001', NOW() - INTERVAL '5 days'),
    ('f1000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000005-0000-0000-0000-000000000005', '01000001-0000-0000-0000-000000000001', 'c1000004-0000-0000-0000-000000000004', 'sca_tool', 'trivy', 'Vulnerable version of golang.org/x/crypto detected', 'critical', 'in_progress', 'fp-techviet-backend-002', NOW() - INTERVAL '3 days'),
    ('f1000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000001-0000-0000-0000-000000000001', NULL, 'sast', 'gosec', 'Hardcoded credentials detected in configuration file', 'high', 'open', 'fp-techviet-backend-003', NOW() - INTERVAL '2 days'),
    ('f1000004-0000-0000-0000-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000011-0000-0000-0000-000000000011', '01000001-0000-0000-0000-000000000001', NULL, 'sast', 'gosec', 'Information disclosure in error messages', 'low', 'open', 'fp-techviet-backend-004', NOW() - INTERVAL '1 day'),

    -- TechViet Frontend Findings
    ('f1000010-0000-0000-0000-000000000010', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000012-0000-0000-0000-000000000012', '01000002-0000-0000-0000-000000000002', NULL, 'sast', 'eslint-security', 'Potential XSS vulnerability in user input handling', 'medium', 'open', 'fp-techviet-frontend-001', NOW() - INTERVAL '4 days'),
    ('f1000011-0000-0000-0000-000000000011', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000002-0000-0000-0000-000000000002', 'c1000013-0000-0000-0000-000000000013', 'sca_tool', 'npm-audit', 'Outdated lodash version with known vulnerabilities', 'medium', 'open', 'fp-techviet-frontend-002', NOW() - INTERVAL '6 days'),
    ('f1000012-0000-0000-0000-000000000012', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000002-0000-0000-0000-000000000002', NULL, 'secret', 'gitleaks', 'API key exposed in source code', 'critical', 'resolved', 'fp-techviet-frontend-003', NOW() - INTERVAL '10 days'),

    -- TechViet Infra Findings
    ('f1000020-0000-0000-0000-000000000020', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000004-0000-0000-0000-000000000004', NULL, 'iac', 'tfsec', 'S3 bucket configured without encryption', 'high', 'open', 'fp-techviet-infra-001', NOW() - INTERVAL '7 days'),
    ('f1000021-0000-0000-0000-000000000021', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000004-0000-0000-0000-000000000004', NULL, 'iac', 'tfsec', 'Security group allows unrestricted ingress on port 22', 'high', 'in_progress', 'fp-techviet-infra-002', NOW() - INTERVAL '5 days'),
    ('f1000022-0000-0000-0000-000000000022', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, '01000004-0000-0000-0000-000000000004', NULL, 'iac', 'checkov', 'RDS instance not encrypted at rest', 'medium', 'open', 'fp-techviet-infra-003', NOW() - INTERVAL '3 days'),

    -- VN Security Findings
    ('f2000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', NULL, '02000001-0000-0000-0000-000000000001', 'c2000003-0000-0000-0000-000000000003', 'sca_tool', 'safety', 'Vulnerable cryptography package version', 'high', 'open', 'fp-vnsec-scanner-001', NOW() - INTERVAL '2 days'),
    ('f2000002-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000012-0000-0000-0000-000000000012', '02000001-0000-0000-0000-000000000001', NULL, 'sast', 'bandit', 'SQL injection vulnerability in database query', 'medium', 'open', 'fp-vnsec-scanner-002', NOW() - INTERVAL '1 day'),
    ('f2000003-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', NULL, '02000002-0000-0000-0000-000000000002', NULL, 'secret', 'trufflehog', 'AWS credentials found in repository history', 'critical', 'in_progress', 'fp-vnsec-tools-001', NOW() - INTERVAL '4 days'),

    -- Startup Hub Findings
    ('f3000001-0000-0000-0000-000000000001', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NULL, '03000001-0000-0000-0000-000000000001', NULL, 'dast', 'zap', 'Missing Content-Security-Policy header', 'low', 'open', 'fp-startup-landing-001', NOW() - INTERVAL '1 day'),
    ('f3000002-0000-0000-0000-000000000002', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '00000012-0000-0000-0000-000000000012', '03000001-0000-0000-0000-000000000001', NULL, 'dast', 'zap', 'Reflected XSS in search parameter', 'medium', 'open', 'fp-startup-landing-002', NOW() - INTERVAL '2 days')
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- 9. EXPOSURES
-- =============================================================================
INSERT INTO exposures (id, tenant_id, asset_id, title, description, category, severity, status, cvss_score, cve_id, source, created_at)
VALUES
    -- TechViet Exposures
    ('e1000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'a1000001-0000-0000-0000-000000000001', 'SSL Certificate Expiring Soon', 'SSL certificate for techviet.vn expires in 30 days', 'certificate', 'medium', 'open', 5.0, NULL, 'ssl-checker', NOW() - INTERVAL '2 days'),
    ('e1000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'a1000004-0000-0000-0000-000000000004', 'Outdated OpenSSH Version', 'OpenSSH version 8.2 detected, recommend upgrade to 9.x', 'vulnerability', 'high', 'open', 7.5, 'CVE-2023-38408', 'nessus', NOW() - INTERVAL '5 days'),
    ('e1000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'a1000007-0000-0000-0000-000000000007', 'PostgreSQL Minor Version Behind', 'PostgreSQL 15.4 should be upgraded to 15.5 for security patches', 'vulnerability', 'medium', 'open', 5.5, NULL, 'database-scanner', NOW() - INTERVAL '3 days'),
    ('e1000004-0000-0000-0000-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'a1000010-0000-0000-0000-000000000010', 'AWS S3 Public Access', 'S3 bucket techviet-public-assets allows public read access', 'misconfiguration', 'high', 'in_progress', 7.0, NULL, 'prowler', NOW() - INTERVAL '1 day'),

    -- VN Security Exposures
    ('e2000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'a2000003-0000-0000-0000-000000000003', 'Kali Linux Outdated Packages', 'Multiple outdated packages detected on pentest workstation', 'vulnerability', 'low', 'open', 3.0, NULL, 'apt-audit', NOW() - INTERVAL '1 day')
ON CONFLICT (id) DO NOTHING;

-- =============================================================================
-- Update project finding counts (trigger should handle this, but ensure correct)
-- =============================================================================
UPDATE projects p
SET finding_count = (
    SELECT COUNT(*)
    FROM findings f
    WHERE f.project_id = p.id
    AND f.status IN ('open', 'in_progress')
);

-- Reset RLS setting
RESET app.current_tenant;

-- =============================================================================
-- Test Data Summary
-- =============================================================================
-- Users: 6 (Password for all: Password123)
-- Tenants: 3
-- Assets: 15
-- Projects: 8
-- Components: 13
-- Vulnerabilities: 12
-- Findings: 16
-- Exposures: 5
-- =============================================================================
