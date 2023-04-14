# Playlist Optimizer (Postgres Database)

Playlist Optimzer is an open-source web application that allows users to analyze their music listening preferences and create playlists accordingly. 

It was born out of a frequent issue I face; skipping song after song in Spotify playlists. When you have hundreds of songs in a playlist, it becomes overwhelming to remove songs you don't want to listen to anymore.

It is a modern re-imagining of [Spotify Playlist Optimizer](https://github.com/jmuzina/spotify_playlist_optimizer), a naïve implementation I made when I was still very new to programming. With the skills I've gained since graduating and getting into industry, I'm looking forward to making this app more modern, performant, and intuitive!
------------------
## Planned features

* **Authenticate**: Authenticate with a variety of music services (Spotify at first, then others if feasible).
* **View your top tracks**: See a list of songs you've been listening to the most over a customizable time frame.
* **Create playlists**: Create new playlists using your top tracks.
* **Compare playlists**: Compare existing playlists with your top tracks.
* **Optimze playlists**: Add, remove, or keep songs to existing playlists based on your top tracks.
------------------
## Architecture
* **Frontend**: An [Angular web app](https://github.com/jmuzina/playlist_optimizer_frontend) for direct user interface.
* **API**: A [Hasura GraphQL Engine](https://github.com/jmuzina/playlist_optimizer_api) instance handles user requests, permissions, and forwards them to the back-end.
* **Backend**: A [NodeJS server](https://github.com/jmuzina/playlist_optimizer_backend) interfaces with music listening service APIs to authenticate users, view their top tracks & playlists, and manipulate playlists.
* **Database**: A [PostgresSQL server](https://github.com/jmuzina/playlist_optimizer_database) database.
------------------
