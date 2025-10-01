# Coolify Deployment Guide for timothyreed.net

This guide walks you through deploying the timothyreed.net static website to Coolify using Docker with security best practices.

## Prerequisites

- Coolify instance secured with HTTPS and proper authentication
- GitHub repository: https://github.com/timothyreed/timothyreed-net
- Domain name: timothyreed.net (with DNS properly configured)
- VPS server secured with SSH hardening and firewall

## Security Features

This deployment includes:
- **Security Headers**: CSP, HSTS, X-Frame-Options, X-Content-Type-Options
- **Non-root Container**: Application runs as non-privileged user
- **Nginx Hardening**: Hidden server tokens, access control
- **Cache Optimization**: Static asset caching for performance
- **HTTPS Only**: Let's Encrypt SSL with automatic renewal

## Deployment Steps

### 1. Access Coolify Dashboard

1. Navigate to your secured Coolify instance (e.g., https://coolify.yourdomain.com)
2. Log in with admin credentials
3. Create or select your project

### 2. Create Application

1. Click **"+ New Resource" → "Application"**
2. Select **"Public Repository"**
3. Configure:
   - **Repository**: `https://github.com/timothyreed/timothyreed-net`
   - **Branch**: `main`
   - **Build Pack**: `Dockerfile`
   - **Dockerfile Location**: `Dockerfile` (root)
   - **Port**: `80`

### 3. Domain & SSL Configuration

1. In **"Domains"** section:
   - Add: `timothyreed.net`
   - Enable **"Generate Let's Encrypt SSL"**
   - Enable **"Force HTTPS"**

### 4. Deploy

1. Click **"Deploy"**
2. Monitor build logs
3. Verify deployment at https://timothyreed.net

### 5. Enable Auto-Deploy

1. In **"Source"** section:
   - Enable **"Auto Deploy"**
   - Coolify creates GitHub webhook automatically

## Architecture

```
GitHub Push → Coolify Webhook → Build Docker Image → Deploy Container → Nginx + Security Headers
```

**Container Stack:**
- Base: `nginx:alpine` (minimal attack surface)
- Security: Non-root user, hardened nginx config
- SSL: Let's Encrypt via Coolify reverse proxy
- Monitoring: Built-in Coolify metrics

## Maintenance

### Updates
- Push to `main` branch triggers automatic deployment
- Monitor deployment logs in Coolify dashboard
- Rollback available via deployment history

### Security
- Review security headers: https://securityheaders.com/
- Monitor SSL: https://www.ssllabs.com/ssltest/
- Regular OS updates handled via Coolify

## Troubleshooting

- **Build Fails**: Check Dockerfile syntax and dependencies
- **SSL Issues**: Verify DNS propagation and domain ownership
- **502 Errors**: Container may be starting (wait 1-2 minutes)
- **Security Headers**: Verify nginx.conf is properly loaded

## Resources

- **Coolify Docs**: https://coolify.io/docs
- **Repository**: https://github.com/timothyreed/timothyreed-net
- **Security Headers**: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
