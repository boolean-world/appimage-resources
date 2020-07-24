#
To build this image you could run ``sh build.sh``
the result will be in ../build.sh

note: when you create an appimage, you need a registered Categories in your _application_.desktop file

you can find the list of categories here : <https://specifications.freedesktop.org/menu-spec/latest/apa.html>


```sh 
export ARCH=$(uname -m)

if [ ! -d ../build ]; then mkdir ../build; fi
if [ ! -x ../build/appimagetool-$ARCH.AppImage ]; then
  curl -L -o ../build/appimagetool-$ARCH.AppImage https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-$ARCH.AppImage
  chmod a+x ../build/appimagetool-$ARCH.AppImage 
fi

../build/appimagetool-$ARCH.AppImage $PWD

mv hello-world-appimage-*-$ARCH.AppImage ../build
```
