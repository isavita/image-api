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
## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Description of the approach

  * __Using ImageMagick for resizing the images__ - The integration is done by [Mogrify wrap library](https://hexdocs.pm/mogrify/Mogrify.html#content).
    I also use adapter module in __image_manipulation__ for wrapping up the functunality and to allow easy teasting with __fake adapter__.
  * __Store of the images__ - This functunality is in another adapter module in __image_store__. The main purpose is to abstract
    the store and to allow easy testing with __fake adapter__ instead of mocks.
  * __The main funcunality is wrapped up in Images module__ - Here is actually all of the public methods used in the two endpoints.
  * __Downloading image from url__ - Both endpoints for validate the image and for resizing the image expect __url to the image__
    the internally download the image and process downloaded copy. There is __limit__ of __2MB__ for the size of the image.
    There valiadation for the image existence and that the file for download is correct image that can be processed.

# Sample of curl's calls for testing

### Endpoints

  * __POST  /images/actions/validate__
  * __POST  /images/actions/resize__

### Validate image endpoint

  * Successful call with existing image
  ```shell
  curl -X POST "localhost:4000/images/actions/validate" -H "Content-Type: application/json" -d '{"image_url":"https://cdn1-www.superherohype.com/assets/uploads/2013/11/batmane3-1.jpg"}'
  ```
  * Call with url to text file
  ```shell
  curl -X POST "localhost:4000/images/actions/validate" -H "Content-Type: application/json" -d '{"image_url":"https://sample-videos.com/text/Sample-text-file-10kb.txt"}'
  ```

### Resize image endpoint

  * Successful call with existing image
  ```shell
  curl -X POST "localhost:4000/images/actions/resize" -H "Content-Type: application/json" -d '{"image_url":"https://cdn1-www.superherohype.com/assets/uploads/2013/11/batmane3-1.jpg", "width":500}'
  ```
  * Failure call due to too big image
  ```shell
  curl -X POST "localhost:4000/images/actions/resize" -H "Content-Type: application/json" -d '{"image_url": "http://insidepulse.com/wp-content/uploads/2018/07/TEC-984-main-cover.png", "width":500}'
  ```
  * Failure call due to __width: "text"__
  ```shell
  curl -X POST "localhost:4000/images/actions/resize" -H "Content-Type: application/json" -d '{"image_url":"https://cdn1-www.superherohype.com/assets/uploads/2013/11/batmane3-1.jpg", "width":"text"}'
  ```
  * Failure to process call when the image does not exist
  ```shell
  curl -X POST "localhost:4000/images/actions/resize" -H "Content-Type: application/json" -d '{"image_url":"https://cdn1-www.superherohype.com/assets/uploads/2013/11/not_here.jpg", "width":500}'
  ```

# Shortcoming/What can be better

  * __No database tables__ - Ecto is not really used. I didn't remove it because dicided later on to go without.
  * __The file is stored locally__ - In reality the file store should be in __AWS__ or similar.
  * __No real url for downloading the resized image__ - Of course, here I should have endpoint that should handle
    download of a file and provide the url to that point instead of path to the file.

