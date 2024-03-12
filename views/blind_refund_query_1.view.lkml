
view: blind_refund_query_1 {
  derived_table: {
    sql: SELECT 
        DATE(b.booking_date) AS 'booking date', DATE(b.ticketed_date) AS 'ticketed date',
        bt.booking_id, rac.am_id, rac.amount, bt.key, 
        b.multiticket_related_booking_id, 
        b.multiticket_relationship_type, rac.source, rac.reason,
        b.status, b.gds, b.gds_account_id,  
        b.departure_airport_code, b.destination_airport_code, 
        b.currency, b.validating_carrier, b.site_version
      FROM bookings b
      INNER JOIN booking_tags bt ON bt.booking_id = b.id
      INNER JOIN 
      (SELECT rab.am_id, rab.booking_id, ra.amount, ra.source, ra.reason
      FROM respro_am AS ra 
      JOIN respro_am_bookings AS rab
      ON rab.am_id = ra.id) AS rac 
      ON rac.booking_id = b.id
      WHERE (bt.key = 'blind_refund_issued'
      AND rac.source = 'accounting_form'
      AND rac.reason = 'Blind Refund')
      ORDER BY b.ticketed_date DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: booking_date {
    type: date
    label: "booking date"
    sql: ${TABLE}.`booking date` ;;
  }

  dimension: ticketed_date {
    type: date
    label: "ticketed date"
    sql: ${TABLE}.`ticketed date` ;;
  }

  dimension: booking_id {
    type: number
    sql: ${TABLE}.booking_id ;;
  }

  dimension: am_id {
    type: number
    sql: ${TABLE}.am_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.`key` ;;
  }

  dimension: multiticket_related_booking_id {
    type: number
    sql: ${TABLE}.multiticket_related_booking_id ;;
  }

  dimension: multiticket_relationship_type {
    type: string
    sql: ${TABLE}.multiticket_relationship_type ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: gds {
    type: string
    sql: ${TABLE}.gds ;;
  }

  dimension: gds_account_id {
    type: string
    sql: ${TABLE}.gds_account_id ;;
  }

  dimension: departure_airport_code {
    type: string
    sql: ${TABLE}.departure_airport_code ;;
  }

  dimension: destination_airport_code {
    type: string
    sql: ${TABLE}.destination_airport_code ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: validating_carrier {
    type: string
    sql: ${TABLE}.validating_carrier ;;
  }

  dimension: site_version {
    type: string
    sql: ${TABLE}.site_version ;;
  }

  set: detail {
    fields: [
        booking_date,
	ticketed_date,
	booking_id,
	am_id,
	amount,
	key,
	multiticket_related_booking_id,
	multiticket_relationship_type,
	source,
	reason,
	status,
	gds,
	gds_account_id,
	departure_airport_code,
	destination_airport_code,
	currency,
	validating_carrier,
	site_version
    ]
  }
}
