# ShareDesk Deployment Guide

## Production Environment Setup

### 1. Environment Variables Setup

The following environment variables must be set on the production server:

```bash
# Required Environment Variables
RAILS_ENV=production
RAILS_MASTER_KEY=your_rails_master_key
DATABASE_URL=postgresql://username:password@host:5432/database_name

# AWS S3 Configuration
AWS_ACCESS_KEY_ID=your_aws_access_key_id
AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key
REGION=us-east-1
S3_BUCKET_NAME=your_s3_bucket_name

# Google Maps API
MAPS_API_KEY=your_google_maps_api_key

# Static File Serving
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true

# OmniAuth Configuration
FACEBOOK_APP_ID=your_facebook_app_id
FACEBOOK_APP_SECRET=your_facebook_app_secret
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
```

### 2. Database Setup

Set up PostgreSQL database and run migrations:

```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

### 3. Asset Compilation

Compile production assets:

```bash
npm install
bundle exec rails webpacker:compile
bundle exec rake assets:precompile
```

### 4. Security Setup

- Verify that Rails Master Key is properly configured
- SSL certificate setup
- Database connection security configuration

### 5. Monitoring

Monitor production logs to check for errors:

```bash
tail -f log/production.log
```

## Common Problem Solutions

### Webpacker Errors
- Run `npm install`
- Run `bundle exec rails webpacker:compile`
- Run `bundle exec rails webpacker:install`

### Database Connection Errors
- Check DATABASE_URL environment variable
- Verify PostgreSQL service status
- Check database permission settings

### AWS S3 Errors
- Verify AWS credentials
- Check S3 bucket permissions
- Verify region settings

### Google Maps API Errors
- Verify API key validity
- Check API quota
- Verify domain restrictions 