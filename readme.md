# SpinupWP: Spin up a WP server using a local Docker container

**Important**: If you ever need to use this method in production you'll need to open port 2222 on your router and replace 127.0.0.1 with your own IP. In local you may use 127.0.0.1 because ansible is run locally.

```bash
git clone git@github.com:vbergerondev/spinupwp-local-docker-server.git
cp .env.example .env
docker compose up --build
```

## Envs
Put anything you want in `ROOT_PASSWORD`

`SPINUPWP_SSH_KEY` should be the same as your `SSH_PUBLICKEY` in your SpinupWP repo

## Instructions
1. Go to Spin Up a New Server
2. Choose "Other provider"
   - IP Address: 127.0.0.1
   - SSH Port: 2222
   - SSH Username: root
   - SSH Authentication: public key (note that the long key you see must be the same as SPINUPWP_SSH_KEY)
3. Click next
   - Hostname: whatever.com
   - Timezone: America/Toronto (having issues with UTC)
4. Click next again, then provision server

Now you have to wait a couple of minutes and notice it failed at step 8/18. Working on it.