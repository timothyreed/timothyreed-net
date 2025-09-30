# Dokploy Deployment Guide for timothyreed.net

This guide walks you through deploying the timothyreed.net static website to Dokploy using Docker.

## Prerequisites

- Dokploy instance running at: http://145.79.1.109:3000
- GitHub repository with your code (recommended) or direct access to your Dockerfile
- Domain name: www.timothyreed.net

## Deployment Steps

### 1. Access Dokploy Dashboard

1. Open your browser and navigate to: **http://145.79.1.109:3000**
2. Log in with your Dokploy credentials
3. You'll see the Dokploy dashboard with your projects

### 2. Create a New Application

1. Click on **"Create Application"** or **"New Project"**
2. Choose **"Docker Compose"** as the application type
   - Alternatively, you can choose **"Dockerfile"** if you want to use the Dockerfile directly

### 3. Configure Your Application

#### Option A: Using GitHub Repository (Recommended)

1. Select **"Git Provider"** as the source
2. Click **"Connect to GitHub"**
3. Authorize Dokploy to access your GitHub repositories
4. Select your repository: `timothyreed/timothyreed-net` (or your GitHub username)
5. Choose the branch: `main`
6. Set the build context path: `/` (root of repository)
7. Dockerfile path: `Dockerfile` or Docker Compose path: `docker-compose.yml`

#### Option B: Using Dockerfile Directly

1. Select **"Upload"** or **"Manual"** deployment
2. Upload your project files including:
   - `Dockerfile`
   - `index.html`
   - `main.css`
   - `assets/` directory
3. Or paste the Dockerfile content directly if that option is available

### 4. Configure Build Settings

1. **Application Name**: `timothyreed-net` (or your preferred name)
2. **Build Method**: 
   - If using docker-compose.yml: Select "Docker Compose"
   - If using Dockerfile: Select "Dockerfile"
3. **Port Configuration**: Set port `80` (the port nginx listens on)
4. **Environment Variables**: None required for this static site

### 5. Set Up Domain and SSL

#### Domain Configuration

1. In the application settings, find the **"Domains"** section
2. Click **"Add Domain"**
3. Enter your domain: `www.timothyreed.net`
4. Also add the root domain: `timothyreed.net` (optional, for redirects)

#### DNS Configuration (External - Do Before SSL)

Before SSL will work, configure your DNS:

1. Go to your domain registrar's DNS management panel
2. Add an **A record**:
   - Host: `www` (or `@` for root domain)
   - Value: `145.79.1.109`
   - TTL: `3600` (or default)
3. Wait for DNS propagation (can take up to 48 hours, usually much faster)
4. Verify with: `nslookup www.timothyreed.net` or `dig www.timothyreed.net`

#### SSL Configuration

1. In the **"SSL/TLS"** section of your application
2. Select **"Let's Encrypt"** (free SSL certificate)
3. Click **"Generate Certificate"**
4. Dokploy will automatically:
   - Request a certificate from Let's Encrypt
   - Configure HTTPS
   - Set up automatic renewal
5. Enable **"Force HTTPS"** to redirect all HTTP traffic to HTTPS

### 6. Deploy the Application

1. Review your configuration
2. Click **"Deploy"** or **"Create & Deploy"**
3. Monitor the build logs in real-time
4. Wait for the deployment to complete (usually 1-3 minutes)

### 7. Verify Deployment

1. Check the application status shows as **"Running"**
2. Visit your domain: https://www.timothyreed.net
3. Verify the website loads correctly
4. Check that SSL certificate is valid (look for the padlock icon)

## Post-Deployment

### Automatic Deployments (GitHub Integration)

If using GitHub:
1. Go to application settings
2. Enable **"Auto Deploy"** on push to `main` branch
3. Every git push will trigger a new deployment automatically

### Manual Redeployment

1. Navigate to your application in Dokploy
2. Click **"Redeploy"** to rebuild and restart
3. Or push changes to your GitHub repository if auto-deploy is enabled

### Monitoring

1. **Logs**: View real-time logs in the Dokploy dashboard
2. **Metrics**: Check CPU, memory, and network usage
3. **Health Checks**: Dokploy automatically monitors your application

### Troubleshooting

#### Application Won't Start
- Check the build logs for errors
- Verify Dockerfile builds correctly locally: `docker build -t test .`
- Ensure port 80 is exposed in Dockerfile

#### Domain Not Accessible
- Verify DNS propagation: `nslookup www.timothyreed.net`
- Check that A record points to: `145.79.1.109`
- Wait for DNS to propagate (up to 48 hours)

#### SSL Certificate Issues
- Ensure DNS is properly configured first
- Domain must be accessible via HTTP before SSL can be issued
- Check Dokploy logs for Let's Encrypt errors
- Verify domain ownership if certificate generation fails

#### 502/503 Errors
- Application may be starting up (wait 1-2 minutes)
- Check application logs for crashes
- Verify nginx is running inside the container

## Architecture Overview

**Deployment Flow:**
```
GitHub Push → Dokploy Webhook → Build Docker Image → Deploy Container → Nginx Serves Static Files
```

**Container Details:**
- Base Image: `nginx:alpine`
- Web Server: Nginx on port 80
- Content: Static HTML/CSS/Images
- SSL: Handled by Dokploy's reverse proxy

## Maintenance

### Updating the Site

1. Make changes to your local files
2. Commit and push to GitHub:
   ```bash
   git add .
   git commit -m "Update website content"
   git push origin main
   ```
3. Dokploy automatically rebuilds and redeploys (if auto-deploy enabled)
4. Or manually trigger redeploy in Dokploy dashboard

### Rollback

1. In Dokploy dashboard, go to **"Deployments"** tab
2. View deployment history
3. Click **"Rollback"** on a previous successful deployment

## Support Resources

- **Dokploy Documentation**: https://docs.dokploy.com
- **Dokploy Dashboard**: http://145.79.1.109:3000
- **Docker Documentation**: https://docs.docker.com
- **Let's Encrypt**: https://letsencrypt.org

## Quick Reference

- **Dokploy URL**: http://145.79.1.109:3000
- **Server IP**: 145.79.1.109
- **Domain**: www.timothyreed.net
- **Container Port**: 80
- **SSL Provider**: Let's Encrypt (free)
- **Web Server**: Nginx Alpine
