FROM archlinux:latest

COPY generate.sh generate.sh

RUN yes | pacman -Syyu
RUN yes | pacman -S python-pip pango python-cffi python-pillow python-brotli python-zopfli ttf-roboto yq git nodejs yarn github-cli qrencode
RUN pip install weasyprint
RUN yarn global add https://github.com/augustinesaidimu/mkdoc

ENTRYPOINT ["/publish.sh"]
