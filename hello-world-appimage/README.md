#
To build this image you could run ``sh build.sh``
the result will be in ../build.sh


```sh 
export ARCH=$(uname -m)

if [ ! -d build ]; then mkdir ../build; fi
if [ ! -x ../build/appimagetool-$ARCH.AppImage ]; then
  curl -L -o ../build/appimagetool-$ARCH.AppImage https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-$ARCH.AppImage
  chmod a+x ../build/appimagetool-$ARCH.AppImage 
fi

../build/appimagetool-$ARCH.AppImage $PWD

mv hello-world-appimage-*-$ARCH.AppImage ../build
```
