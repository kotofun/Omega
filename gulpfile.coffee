'use strict'

gulp = require 'gulp'
pug = require 'gulp-pug'
prefix = require 'gulp-autoprefixer'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
bs = require 'browser-sync'

paths =
	pages: './src/pages/*.pug'
	styles: './src/styles/styles.sass'
	images: './src/images/**/*.{png,jpg,jpeg,gif,svg}'
	fonts: './src/fonts/**/*.{ttf,eot,woff,woff2,svg}'
	scripts: './src/scripts/**/*.coffee'
	dist:
		pages: './dist/'
		styles: './dist/styles/'
		images: './dist/images/'
		fonts: './dist/fonts/'
		scripts: './dist/scripts/'

gulp.task 'pug', ->
	gulp.src paths.pages
		.pipe pug pretty: true
		.pipe gulp.dest paths.dist.pages
		.pipe bs.stream()

gulp.task 'styles', ->
	gulp.src paths.styles
		.pipe sass()
		.pipe gulp.dest paths.dist.styles
		.pipe bs.stream()

gulp.task 'images', ->
	gulp.src paths.images
		.pipe gulp.dest paths.dist.images
		.pipe bs.stream()

gulp.task 'fonts', ->
	gulp.src paths.fonts
		.pipe gulp.dest paths.dist.fonts
		.pipe bs.stream()

gulp.task 'scripts', ->
	gulp.src paths.scripts
		.pipe coffee()
		.pipe gulp.dest paths.dist.scripts
		.pipe bs.stream()

gulp.task 'build', ['pug', 'styles', 'images', 'scripts', 'fonts']

gulp.task 'watch', ->
	bs.init server: './dist'
	gulp.watch paths.pages, ['pug']
	gulp.watch [paths.styles, './src/styles/**/*.sass'], ['styles']
	gulp.watch paths.scripts, ['scripts']
	gulp.watch paths.images, ['images']
	gulp.watch paths.fonts, ['fonts']

gulp.task 'default', ['watch', 'build']
