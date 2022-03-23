
# Docker-PlexAniSync for Truenas Scale
[Docker Link](https://hub.docker.com/r/jimmyhiggs337/plexanisync-truenasscale)

Based off of [Rickdb's PlexAniSync](https://github.com/RickDB/Docker-PlexAniSync)

Moves all Environment variables ONLY into the settings.ini file to account for TrueNas Scale's 1024 variable size

## Usage

### Docker Run

```
docker run -d \
  --name=plexanisync \
  --restart unless-stopped \
  -e SETTINGS_FILE=/config/settings.ini
  -v /etc/localtime:/etc/localtime:ro \
  jimmyhiggs337/plexanisync-truenasscale:latest
```

### Truenas Scale
#### Container Images 
| Image repository | jimmyhiggs337/plexanisync-truenasscale|
| ------------------------- | -------------------------- |


#### Container Environment Variables

| Environment Variable Name | Environment Variable Value |
| ------------------------- | -------------------------- |
| SETTINGS_FILE             | /path/to/config/file.ini   |

#### Storage: Configure Host Path Volumes

| Host Path                       | Mount Path                            |
| ------------------------------- | ------------------------------------- |
| /path/on/nas/to/config/file.ini | /env/variable/path/to/config/file.ini |

### Environment Variables

| ID            | Default              | Required | Note                                                                                                                               |
| ------------- | -------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| SETTINGS_FILE | /config/settings.ini | ✅       | Location of a custom settings.ini for more advanced configuration. See section below for usage. |
| INTERVAL      | 3600                 | ✅       | The time in between syncs in seconds                                                                                               |

### Custom mappings

In order to provide a [custom_mappings.yaml file](https://github.com/RickDB/PlexAniSync#custom-anime-mapping), mount the file on your host to `/plexanisync/custom_mappings.yaml` like this:

```
-v /path/to/your/custom_mappings.yaml:/plexanisync/custom_mappings.yaml
```

You can modify the file on the host system anytime and it will be used during the next run. Restarting the container is not necessary.

### Custom settings.ini

If you want to use other Plex login mechanisms, you can use your own settings.ini file by mapping it into the container and setting the environment variable `SETTINGS_FILE` with the path to the file inside the container.

If the settings file is located at `/docker/plexanisync/settings.ini` and you want to place it to `/config/settings.ini`, use the following volume mapping and environment variable:

```
-v '/docker/plexanisync/config/settings.ini:/config/settings.ini:rw'
-e 'SETTINGS_FILE=/config/settings.ini'
```

### Settigns.ini Example

```
[PLEX]
anime_section = Anime

 # Choose 'direct' or 'myplex'
authentication_method = direct

# Direct IP
base_url = http://127.0.0.1:32400
token = abcdef123456789

# MyPlex
server = Sadala
myplex_user = John
myplex_password = Doe

# if you enable home_user_sync it will only sync against that specific Plex home user, it requires the full url of your Plex server just like with the Direct IP method
# home_username is the actual Plex home username and not their e-mail address, this is also case sensitive

home_user_sync = False
home_username = Megumin
home_server_base_url = http://127.0.0.1:32400

[ANILIST]
access_token = SomeVeryLongAccessToken
plex_episode_count_priority = False
skip_list_update = False
username = SomeUsername
log_failed_matches = False

```
