# Natsukashii ( ・_・)ノ

Natsukashii is a simple photographic time machine that can find and show photos you took on today's date in the past. Here is what Natsukashii can do.

1. Find photos matching the current day and month
2. Create an animated GIF out of the found photos
3. Serve the found photos on the local machine using a simple PHP application
4. Upload the found photos to a remote server via FTP

Natsukashii runs on Linux, and it has been tested on Linux Mint and openSUSE.

## Dependencies

- PHP
- ExifTool
- ImageMagick
- sed
- seq
- cURL
- ncftp (optional)
- Git (optional)

## Installation and Usage

1. Install the required packages on the machine that has all your photos. To do this on Linux Mint, run the command `sudo apt install php-cli exiftool imagemagick sed coreutils curl ncftp git`. On openSUSE, use the command `sudo zypper install php-cli exiftool ImageMagick sed coreutils curl ncftp git`.
2. Use the following command to clone the project's Git repository in the desired location on the machine: `git clone https://github.com/dmpop/natsukashii.git`. Alternatively, grab the latest source code manually from the project's GitHub page, and unpack the downloaded archive.
3. Edit the `config.cfg` configuration file.
4. Switch to the *natsukashii/www* directory and change the default password in the _/login.php_ and _/protect.php_ files.
5. Switch to the *natsukashii* directory and run the *natsukashii.sh* script using the `./natsukashii.sh` command.

## Problems?

Please report bugs and issues in the [Issues](https://github.com/dmpop/natsukashii/issues) section.

## Contribute

If you've found a bug or have a suggestion for improvement, open an issue in the [Issues](https://github.com/dmpop/natsukashii/issues) section.

To add a new feature or fix issues yourself, follow the following steps.

1. Fork the project's repository.
2. Create a feature branch using the `git checkout -b new-feature` command.
3. Add your new feature or fix bugs and run the `git commit -am 'Add a new feature'` command to commit changes.
4. Push changes using the `git push origin new-feature` command.
5. Submit a pull request.

## Author

Dmitri Popov [dmpop@linux.com](mailto:dmpop@linux.com)

## License

The [GNU General Public License version 3](http://www.gnu.org/licenses/gpl-3.0.en.html)

