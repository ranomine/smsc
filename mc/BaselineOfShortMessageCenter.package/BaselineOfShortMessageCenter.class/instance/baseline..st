as yet unclassified
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Voyage'
				with: [ spec repository: 'github://pharo-nosql/voyage:1.5.4/mc' ].
			spec
				baseline: 'SMPPCodec'
				with: [ spec repository: 'github://moiji-mobile/smpp-codec:v2/mc' ].
			spec
				baseline: 'StatsD'
				with: [ spec repository: 'github://moiji-mobile/statsd:v6/source' ].
			spec
				baseline: 'OsmocomLogging'
				with: [ spec repository: 'github://moiji-mobile/osmocom-logging:v8/source' ].
			spec
				baseline: 'ShortMessage'
				with:
					[ spec repository: 'github://moiji-mobile/short-message:master/source' ].
			spec
				baseline: 'TCAP'
				with: [ spec repository: 'github://moiji-mobile/tcap:v12/source' ].
			spec
				baseline: 'ASN1'
				with: [ spec
						repository: 'github://noha/ASN.1:pharo7/src';
						loads: #all ].
			spec
				baseline: 'ZincHTTPComponents'
				with: [ spec
						loads: #('REST');
						repository: 'github://svenvc/zinc:v4/repository' ].
			spec
				package: #'ShortMessageCenter-Database'
				with: [ spec requires: #('Voyage' 'OsmoLogging') ].
			spec
				package: #'ShortMessageCenter-Inserter'
				with: [ spec requires: #('ShortMessageCenter-Database' 'OsmoLogging') ].
			spec
				package: #'ShortMessageCenter-Delivery'
				with: [ spec
						requires: #('ShortMessageCenter-Database' 'OsmoLogging' 'ASN1' 'TCAP') ].
			spec
				package: #'ShortMessageCenter-REST'
				with: [ spec
						requires: #('ShortMessageCenter-Database' 'ZincHTTPComponents' 'OsmoLogging') ] ]