source("do_Q.R")
# for parsing JSON responce in GET-IT popup ----
json <- '{"payload":{"links":{"next":null,"previous":null},"total":1,"page":1,"page_size":10,"fois":[{"id":1,"identifier":"http://www.get-it.it/featureOfInterest/SI000049-917","name":"SI000049-917","sosUrl":"http://getit.lteritalia.it/observations/sos","codespace":"http://www.opengis.net/def/nil/OGC/0/unknown","feature_type":"http://www.opengis.net/def/samplingFeatureType/OGC-OM/2.0/SF_SamplingPoint","sampled_feature":"http://getit.lteritalia.it/layers/geonode:LTER_EU_AT_003","geom":{"type":"Point","coordinates":[47.876667,14.33333]},"procedure":{"pk":2,"id":"http://www.get-it.it/sensors/getit.lteritalia.it/procedure/noOwnerDeclared/noModelDeclared/noSerialNumberDeclared/SI000049-917AirTemp","offeringsIDs":["offering:http://www.get-it.it/sensors/getit.lteritalia.it/procedure/noOwnerDeclared/noModelDeclared/noSerialNumberDeclared/SI000049-917AirTemp/observations"],"observablePropertiesIDs":["http://www.opengis.net/def/property/OGC/0/PhenomenonTime","http://vocabs.lter-europe.net/EnvThes/22035"]}}]},"clickCoordinates":{"lat":47.90898,"lng":14.37012}}'
# requests ----
# 1. GetObservation 
# base url: https://dev.get-it.it/observations/service?
# service: service=SOS&
# version version=2.0.0&
# request: request=GetObservation&
# offering: offering=http%3A%2F%2Fwww.52north.org%2Ftest%2Foffering%2F1&
# observedProperty: observedProperty=http%3A%2F%2Fwww.52north.org%2Ftest%2FobservableProperty%2F1%2Chttp%3A%2F%2Fwww.52north.org%2Ftest%2FobservableProperty%2F2&
# procedure: procedure=http%3A%2F%2Fwww.52north.org%2Ftest%2Fprocedure%2F1&
# namespaces: namespaces=xmlns(sams%2Chttp%3A%2F%2Fwww.opengis.net%2FsamplingSpatial%2F2.0)%2Cxmlns(om%2Chttp%3A%2F%2Fwww.opengis.net%2Fom%2F2.0)&
# spatialFilter: spatialFilter=om%3AfeatureOfInterest%2F*%2Fsams%3Ashape%2C0.0%2C0.0%2C60.0%2C60.0%2Curn%3Aogc%3Adef%3Acrs%3AEPSG%3A%3A4326&
# temporalFilter=om%3AphenomenonTime%2C2012-11-19T14%3A00%3A00%2B01%3A00%2F2012-11-19T14%3A15%3A00%2B01%3A00
# query ----
query <- '{
     sosUrl: .payload.fois[0].sosUrl,
     offering: .payload.fois[0].procedure.offeringsIDs[0],
     observedProperty: .payload.fois[0].procedure.observablePropertiesIDs,
     procedure: .payload.fois[0].procedure.id
    }'

get_obsProp_params <- function(url_popup = NULL, q, jj) {
  q <- query
  jj <- json
  get_obs_properties <- dplyr::as_tibble(do_Q(q, jj))
  get_obs_properties
}
params <- get_obsProp_params(q = query, jj = json)
