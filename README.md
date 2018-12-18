# Image API

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Setup the project

## Install ImageMagick [link](https://imagemagick.org/script/install-source.php)
  * Download ImageMagick
  ```shell
  wget -O ~/ImageMagick.tar.gz https://imagemagick.org/download/ImageMagick.tar.gz
  ```
  * Unzip `ImageMagick.tar.gz` file
  ```shell
  cd ~
  tar xvzf ImageMagick.tar.gz
  ```
  * Install latest version of ImageMagick
  ```shell
  cd ImageMagick-X.X.X
  ./configure
  make
  sudo make install
  sudo ldconfig /usr/local/lib
  ```
