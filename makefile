build:
	@docker build -t scratch .
buildnc:
	@docker build --no-cache -t scratch .
runti:
	@docker run -ti --name scratched scratch zsh
runsu:
	@docker run -ti --name scratched --user root scratch zsh
runtmp:
	@docker run -ti --rm scratch zsh
rm:
	@docker rm scratched
