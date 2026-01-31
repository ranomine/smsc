as yet unclassified
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'Voyage' with: [
				spec repository: 'github://pharo-nosql/voyage/mc'].
		spec baseline: 'SMPP' with: [
				spec repository: 'github://ranomine/smpp-codec:pharo13/mc'].
		spec baseline: 'StatsDClient' with: [
				spec repository: 'github://moiji-mobile/statsd/source'].
		spec baseline: 'OsmoLogging' with: [
				spec repository: 'github://moiji-mobile/osmocom-logging/source'].
		spec baseline: 'ShortMessage' with: [
				spec repository: 'github://moiji-mobile/short-message/source'].
		spec baseline: 'TCAP' with: [
				spec repository: 'github://moiji-mobile/tcap/source'].
		spec baseline: 'ASN1' with: [
				spec repository: 'github://noha/ASN.1/src'].
		spec baseline: 'ZincHTTPComponents' with: [
				spec
					loads: #('REST');
					repository: 'github://svenvc/zinc/repository'].

		spec package: #'ShortMessageCenter-Database' with: [
			spec requires: #('Voyage' 'OsmoLogging') ].
		spec package: #'ShortMessageCenter-Inserter' with: [
			spec requires: #('ShortMessageCenter-Database' 'OsmoLogging')].
		spec package: #'ShortMessageCenter-Delivery' with: [
			spec requires: #('ShortMessageCenter-Database' 'OsmoLogging' 'ASN1' 'TCAP')].
		spec package: #'ShortMessageCenter-REST' with: [
			spec requires: #('ShortMessageCenter-Database' 'ZincHTTPComponents' 'OsmoLogging')]].
