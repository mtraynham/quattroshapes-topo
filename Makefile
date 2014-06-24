TOPOJSON = node_modules/.bin/topojson

all: \
	gn-qs_localities \
	qs_adm0 \
	qs_adm1 \
	qs_adm1_region \
	qs_adm2 \
	qs_adm2_region \
	qs_localadmin \
	qs_localities \
	qs_neighborhoods \

# gn-qs_localities.zip    quatroshapes localities (with geonames concordance)     420 mb
gn-qs_localities: \
	topojson/gn-qs_localities.json \
# qs_adm0.zip             quatroshapes admin 0                                    106 mb
qs_adm: \
	topojson/qs_adm0.json \
# qs_adm1.zip             quatroshapes admin 1                                    106 mb
qs_adm1: \
	topojson/qs_adm1.json \
# qs_adm1_region.zip      quatroshapes admin 1 regions                            17 mb
qs_adm1_region: \
	topojson/qs_adm1_region.json \
# qs_adm2.zip             quatroshapes admin 2                                    304 mb
qs_adm2: \
	topojson/qs_adm2.json \
# qs_adm2_region.zip      quatroshapes admin 2 regions                            1.5 mb
qs_adm2_region: \
	topojson/qs_adm2_region.json \
# qs_localadmin.zip       quatroshapes local admin                                467 mb
qs_localadmin: \
    topojson/qs_localadmin.json \
# qs_localities.zip       quatroshapes localities                                 420 mb
qs_localities: \
	topojson/qs_localities.json \
# qs_neighborhoods.zip    quatroshapes neighborhoods                              32 mb
qs_neighborhoods: \
	topojson/qs_neighborhoods.json \

.SECONDARY:

zip/%.zip:
	mkdir -p $(dir $@)
	curl "http://static.quattroshapes.com/$*.zip" -o $@.download
	mv $@.download $@

shp/%: zip/%.zip
	mkdir -p $@
	unzip -d $@ $<
	touch $@

topojson/%.json: shp/%
	mkdir -p $(dir $@)
	$(TOPOJSON) -o $@ -p -- shp/$*/$*.shp

clean:
	rm -rf topojson/*