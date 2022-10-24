
apt-get -qqq update

# CALIBRE
if [ ! -d /opt/calibre ] 
then
  apt-get -qqq install -y wget python3 libegl1 libopengl0 xdg-utils libnss3 xz-utils
  cd /tmp && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | bash /dev/stdin version=$CALIBRE_VERSION install_dir=/opt
fi  

# CALIBRE WEB

if [ ! -d $CALIBRE_DBPATH ] 
then 
  apt-get -qqq install -y apt-utils unzip p7zip busybox python3-pip imagemagick
  cd /tmp
  wget https://github.com/janeczku/calibre-web/releases/download/$CALIBRE_WEB_VERSION/calibre-web-$CALIBRE_WEB_VERSION.tar.gz
  tar -xzf /tmp/calibre-web-$CALIBRE_WEB_VERSION.tar.gz
  cp -rfv calibre-web-$CALIBRE_WEB_VERSION /opt/calibre-web
  pip3 install 'flask<2.1.0' \
                   'flask_login<0.6.2' \
                   flask_principal \
                   sqlalchemy \
                   'tornado<6.2' \
                   'requests<2.28.0' \
                   flask_babel \
                   unidecode \
                   pycountry \
                   flask-WTF \
                   'chardet<4.1.0' \
                   APScheduler \
                   advocate \
                   'lxml<4.9.0' \
                   Wand \
                   iso-639 \
                   backports_abc \
                   werkzeug==2.1.2 \
                   PyPDF3 \
                   unrar \
                   'lxml>=3.8.0'  \
                   'Pillow>=4.0.0'  \
                   Flask-Dance
  sed -i "s/lm.session_protection = 'strong'/lm.session_protection = 'none'/g" /opt/calibre-web/cps/__init__.py 
fi

python3 /opt/calibre-web/cps.py -v 
sleep 10 && tail -f /opt/calibre-web/calibre-web.log & 
exec python3 /opt/calibre-web/cps.py &
