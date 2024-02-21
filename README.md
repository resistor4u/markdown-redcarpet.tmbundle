# TextMate Bundle for GitHub's Redcarpet Markdown

These instructions were changed 2024-02-21 to work with more recent MacOS versions. First, put this bundle in your TextMate bundle directory:

```bash
# Textmate2
mkdir -p ~/Library/Application\ Support/TextMate/Bundles/
cd ~/Library/Application\ Support/TextMate/Bundles/
git clone -b sillycon https://github.com/resistor4u/markdown-redcarpet.tmbundle.git

cd Support/gems
# remove the old dirs
gem unpack redcarpet -v '~> 3.4'
gem unpack rouge -v '~> 2.0.7'
gem unpack rake-compiler -v '~> 1.0.3'

cd redcarpet-3.4...

rake -I../rake-compiler-1.0.3/lib compile
```

### Supported syntaxes inside fenced blocks

The following syntaxes will be highlighted inside the fenced block:

- Ruby
- Javascript (as js, javascript)
- CoffeeScript (as coffee, coffeescript)
- Shell (as shell, bash, sh)
- Haml
- R

Reload TextMate and tell it to read `.md` files as Markdown Redcarpet types.

You will need a theme that is properly scoped to render the syntax. Check whichever theme is currently in use, and go to edit `~/Library/Application\ Support/TextMate/Bundles/Themes.tmbundle/Themes/___YOURTHEMENAME___.thTheme`. You will minimally want the following entry:
```xml
			<dict>
				<key>name</key>
				<string>R embedded code</string>
				<key>scope</key>
				<string>source.r.embedded.rmarkdown</string>
				<key>settings</key>
				<dict>
					<key>foreground</key>
					<string>#60A365</string>
					<key>background</key>
					<string>#58534F</string>
					<key>fontSize</key>
					<string></string>
					<key>fontName</key>
					<string>Consolas</string>
					<key>fontStyle</key>
					<string>italic</string> <!-- You can specify additional font styles if needed -->
				</dict>
			</dict>			
		</array>
	</dict>
```
The `foreground` and `background` colors are just for demo, so change them. Note: the key to changing the font is `fontName` and **__NOT__** `fontFamily`.


For more information about GitHub's Redcarpet markdown, [checkout this post][github-flavored-markdown].


[github-flavored-markdown]: http://github.github.com/github-flavored-markdown/
[github-theme]: https://github.com/kneath/github_textmate_preview

## R Markdown

This bundle also supports [R Markdown](http://www.rstudio.com/ide/docs/r_markdown) files (Rmd, rmd) by properly scoping fenced [R code](http://cran.r-project.org/) chunks and inline R code to the R source syntax when used with the [R TextMate bundle](https://github.com/textmate/r.tmbundle). You can then use the commands from the [R TextMate bundle](https://github.com/textmate/r.tmbundle) to evaluate R code, send it to the R GUI, etc. This bundle includes two commands to _knit_ R Markdown files and produce the HTML result: one uses the [knitr](http://cran.r-project.org/web/packages/knitr/index.html) package while the other one (recommended, see why [here](http://lcolladotor.github.io/2013/12/10/knitrBootstrap/)) uses the [knitrBootstrap](http://cran.at.r-project.org/web/packages/knitrBootstrap/index.html) package.

For R noweb files (Rnw, rnw) you might be interested in the [knitr TextMate bundle](https://github.com/fonnesbeck/knitr.tmbundle) which bridges LaTeX and R code.
