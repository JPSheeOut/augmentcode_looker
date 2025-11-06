view: platform_full_funnel {
  sql_table_name: `production.platform_full_funnel` ;;

  dimension_group: _ {
    description: ""
    type: time
    group_label: "- Time Period"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }


  dimension: ad_group {
    description: "Ad groups contains one or more ads that share similar targets, audiences or offers"
    type: string
    sql: ${TABLE}.ad_group ;;
  }

  dimension: campaign {
    description: "Campaigns are a set of ad groups of (ads, keywords, bids, offers, regions, etc) that share a budget or objective"
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_type {
    description: "Campaign type is derived from the campaign or ad group name to sort into important categories such as generic search, brand search, competitor search, display, discovery, social"
    type: string
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: platform {
    description: "Groups data by advertising platforms like Google, Bing, Facebook, LinkedIn, Reddit, Quora, etc."
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: region {
    description: "Groups data by advertising region such as AMER, EMEA, APAC, or any other geographical breakdown"
    type: string
    sql: ${TABLE}.region ;;
  }

#MEASURES START HERE
  measure: total_clicks {
    description: "Sums the total number of clicks. Clicks are counted each time your ad is clicked, each platform has unique methods for defining how they are counted"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.clicks ;;
  }

  measure: total_impressions {
    description: "Sums the total number of impressions. An impression is counted each time your ad is shown"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.impressions ;;
  }

  measure: total_spend {
    description: "Sums the total advertising spend across all platforms"
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.spend ;;
  }

  measure: total_credit_card_added {
    description: "Sums the in platform credit card added conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.credit_card_added ;;
  }

  measure: total_demo_form_submits {
    description: "Sums the in platform demo form submit conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.demo_form_submitted ;;
  }

  measure: total_installs {
    description: "Sums the in platform install conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.installs ;;
  }

  measure: total_sign_up_page_loaded {
    description: "Sums the in platform sign up page loaded conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.sign_up_page_loaded ;;
  }

  measure: total_activated {
    description: "Sums the in platform activated conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.activated ;;
  }

  measure: total_signed_up {
    description: "Sums the in platform signed up conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.signed_up ;;
  }

  measure: total_customers {
    description: "Sums the in platform customer conversions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.customer ;;
  }

  measure: total_sessions_attributed {
    description: "Sums the total sessions metric from the augment data export"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_sessions_attributed ;;
  }

  measure: total_signups_attributed {
    description: "Sums the signups metric from the augment data export"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.signups_attributed ;;
  }
  measure: total_installations_attributed {
    description: "Sums the installations metric from the augment data export"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.installation_attributed ;;
  }
  measure: total_activations_attributed {
    description: "Sums the activations metric from the augment data export"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.activations_attributed ;;
  }
  measure: total_payments_attributed {
    description: "Sums the paments metric from the augment data export"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.payments_attributed ;;
  }



  ##START Calculated Measures Here

  measure: ctr {
    label: "CTR"
    description: "(Total Clicks/Total Impressions)"
    type: number
    value_format_name: percent_2
    sql: ${total_clicks} / NULLIF(${total_impressions}, 0);;
  }

  measure: cpc {
    label: "CPC"
    description: "(Total Spend/Total Clicks)"
    type: number
    value_format_name: usd
    sql: ${total_spend} / NULLIF(${total_clicks}, 0);;
  }

  measure: cp_credit_card_added {
    label: "Cost per Credit Card Added"
    description: "(Total Spend/Total Credit Card Added"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_credit_card_added}, 0);;
  }

  measure: cp_demo_form_submit {
    label: "Cost per Demo Form Submits"
    description: "(Total Spend/Total Demo Form Submits)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_demo_form_submits}, 0);;
  }

  measure: cp_install {
    label: "Cost per Install"
    description: "(Total Spend/Total Installs)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_installs}, 0);;
  }

  measure: cp_sign_up_page_loaded{
    label: "Cost per Sign Up Page Loaded"
    description: "(Total Spend/Total Sign Up Page Loaded)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_sign_up_page_loaded}, 0);;
  }

  measure: cp_activated{
    label: "Cost per Activated"
    description: "(Total Spend/Total Activated)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_activated}, 0);;
  }

  measure: cp_signed_up{
    label: "Cost per Signup"
    description: "(Total Spend/Total Signed Up)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_signed_up}, 0);;
  }

  measure: cp_customer{
    label: "Cost per Customer"
    description: "(Total Spend/Total Customer)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_customers}, 0);;
  }

  measure: signup_cvr {
    label: "Signup CVR"
    description: "(Total Signups/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_signed_up} / NULLIF(${total_clicks}, 0);;
  }

  measure: activated_cvr {
    label: "Activated CVR"
    description: "(Total Activated/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_activated} / NULLIF(${total_clicks}, 0);;
  }

  measure: credit_card_cvr {
    label: "Credit Card Added CVR"
    description: "(Total Credit Card Added/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_credit_card_added} / NULLIF(${total_clicks}, 0);;
  }

  measure: customer_cvr {
    label: "Customer CVR"
    description: "(Total Customers/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_customers} / NULLIF(${total_clicks}, 0);;
  }

  measure: cp_session_attributed {
    label: "Cost per Session Attributed"
    description: "(Total Spend/Total Session Attributed)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_sessions_attributed}, 0);;
  }

  measure: cp_signup_attributed{
    label: "Cost per Signup Attributed"
    description: "(Total Spend/Total Signup Attributed)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_signups_attributed}, 0);;
  }

  measure: cp_activation_attributed{
    label: "Cost per Activation Attributed"
    description: "(Total Spend/Total Activations Attributed)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_activations_attributed}, 0);;
  }

  measure: cp_installation_attributed{
    label: "Cost per Installation Attributed"
    description: "(Total Spend/Total Installations Attributed)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_installations_attributed}, 0);;
  }

  measure: cp_payments_attributed{
    label: "Cost per Payment Attributed"
    description: "(Total Spend/Total Payments Attributed)"
    type: number
    value_format_name: usd_0
    sql: ${total_spend} / NULLIF(${total_payments_attributed}, 0);;
  }

  measure: sessions_attributed_cvr{
    label: "Sessions Attributed CVR"
    description: "(Total Sessions Attributed/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_sessions_attributed} / NULLIF(${total_clicks}, 0);;
  }


  measure: signup_attributed_cvr{
    label: "Signup Attributed CVR"
    description: "(Total Signup Attributed/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_signups_attributed} / NULLIF(${total_clicks}, 0);;
  }


  measure: activation_attributed_cvr{
    label: "Activation Attributed CVR"
    description: "(Total Activations Attributed/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_activations_attributed} / NULLIF(${total_clicks}, 0);;
  }


  measure: installations_attributed_cvr{
    label: "Installations Attributed CVR"
    description: "(Total Installations Attributed/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_installations_attributed} / NULLIF(${total_clicks}, 0);;
  }

  measure: payments_attributed_cvr{
    label: "Payments Attributed CVR"
    description: "(Total Payments Attributed/Total Clicks)"
    type: number
    value_format_name: percent_2
    sql: ${total_payments_attributed} / NULLIF(${total_clicks}, 0);;
  }




}
