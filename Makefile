APP_NAME=teste
#cria o container
run:
		docker run -it --rm -p 88:8088 $(APP_NAME)
#abre o terminal
shell:
		docker run -it --rm -p 88:8088 $(APP_NAME) /bin/sh
#cria a imagem
build:
		docker build -t $(APP_NAME) .
