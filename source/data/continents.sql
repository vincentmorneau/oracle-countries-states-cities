merge into ogd_continents target
using (
    select *
    from geonames g
    where g.feature_class = 'L'
    and g.feature_code = 'CONT'
) source
on (target.geonameid = source.geonameid)
when matched then
    update set
      target.name = source.name
    , target.asciiname = source.asciiname
    , target.latitude = source.latitude
    , target.longitude = source.longitude
    , target.feature_class = source.feature_class
    , target.feature_code = source.feature_code
    , target.country_code = source.country_code
    , target.cc2 = source.cc2
    , target.admin1_code = source.admin1_code
    , target.admin2_code = source.admin2_code
    , target.admin3_code = source.admin3_code
    , target.admin4_code = source.admin4_code
    , target.population = source.population
    , target.elevation = source.elevation
    , target.dem = source.dem
    , target.timezone = source.timezone
    , target.modification_date = source.modification_date
when not matched then
    insert (
        geonameid
        , name
        , asciiname
        , latitude
        , longitude
        , feature_class
        , feature_code
        , country_code
        , cc2
        , admin1_code
        , admin2_code
        , admin3_code
        , admin4_code
        , population
        , elevation
        , dem
        , timezone
        , modification_date
    ) values (
        source.geonameid
        , source.name
        , source.asciiname
        , source.latitude
        , source.longitude
        , source.feature_class
        , source.feature_code
        , source.country_code
        , source.cc2
        , source.admin1_code
        , source.admin2_code
        , source.admin3_code
        , source.admin4_code
        , source.population
        , source.elevation
        , source.dem
        , source.timezone
        , source.modification_date
    );

-- adding missing continent_code
update ogd_continents set continent_code = 'AS' where upper(name) = 'ASIA' and continent_code is null;
update ogd_continents set continent_code = 'AF' where upper(name) = 'AFRICA' and continent_code is null;
update ogd_continents set continent_code = 'NA' where upper(name) = 'NORTH AMERICA' and continent_code is null;
update ogd_continents set continent_code = 'AN' where upper(name) = 'ANTARCTICA' and continent_code is null;
update ogd_continents set continent_code = 'OC' where upper(name) = 'OCEANIA' and continent_code is null;
update ogd_continents set continent_code = 'EU' where upper(name) = 'EUROPE' and continent_code is null;
update ogd_continents set continent_code = 'SA' where upper(name) = 'SOUTH AMERICA' and continent_code is null;
