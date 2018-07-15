# Natsukashii :cherry_blossom: 懐かしい

Natsukashii is a Bash shell script that can find photos taken on today's date a year ago.

## Dependencies

- ExifTool
- ImageMagick
- sed
- seq
- Git (optional)

## Intstallation and Usage

1. Install the required packages on the machine that has all your photos.
2. Use the following command to clone the project's Git repository in the desired location on the machine: ` git clone https://gitlab.com/dmpop/natsukashii.git`. Alternatively, grab the latest source code manually from the project's GitLab page, and unpack the downloaded archive.
3. Switch to the resulting *natsukashii* directory and run the *natsukashii.sh* script using the `./natsukashii.sh` command.
4. During the first run, provide the required information.

By default, Natsukahii searches for photos from exactly one year ago. To search for photos taken on this date in any previous year, add the `all` flag to the command: `./natsukashii all`.

The [Linux Photography](https://gumroad.com/l/linux-photography) book provides detailed information  on installing and using Natsukashii. Get your copy at [Google Play Store](https://play.google.com/store/books/details/Dmitri_Popov_Linux_Photography?id=cO70CwAAQBAJ) or [Gumroad](https://gumroad.com/l/linux-photography).

<img src="https://scribblesandsnaps.files.wordpress.com/2016/07/linux-photography-6.jpg" width="200"/>

## Problems?

Please report bugs and issues in the [Issues](https://gitlab.com/dmpop/natsukashii/issues) section.

## Contribute

If you've found a bug or have a suggestion for improvement, open an issue in the [Issues](https://gitlab.com/dmpop/natsukashii/issues) section.

To add a new feature or fix issues yourself, follow the following steps.

1. Fork the project's repository repository
2. Create a feature branch using the `git checkout -b new-feature` command
3. Add your new feature or fix bugs and run the `git commit -am 'Add a new feature'` command to commit changes
4. Push changes using the `git push origin new-feature` command
5. Submit a merge request

## Author

Dmitri Popov [dmpop@linux.com](mailto:dmpop@linux.com)

## License

The [GNU General Public License version 3](http://www.gnu.org/licenses/gpl-3.0.en.html)

<noscript><a href="https://liberapay.com/dmpop/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript>
