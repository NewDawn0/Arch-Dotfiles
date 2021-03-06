#!/usr/bin/sh
wikidir="/usr/share/doc/arch-wiki/html/en/"
wikidocs="$(find ${wikidir} -iname "*.html")"

main () {
	choice=$(printf '%s\n' "${wikidocs[@]}" | \
		cut -d '/' -f8- | \
		sed -e 's/_/ /g' -e 's/.html//g' | \
		dmenu -i -p 'Arch Wiki Docs: ') || exit 1
	if [ "$choice" ]; then
		article=$(printf '%s\n' "${wikidir}${choice}.html" | sed 's/ /_/g')
		brave "$article"
	else
		echo "Programm terminated." && exit 0
	fi
}
main
