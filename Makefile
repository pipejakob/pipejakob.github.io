.PHONY: build serve bootstrap update clean nuke

build:
	bundle exec jekyll build --drafts

serve:
	bundle exec jekyll serve --drafts

bootstrap:
	bundle install --path _vendor

update:
	bundle update

clean:
	$(RM) -r _site

nuke: clean
	$(RM) -r .bundle _vendor
