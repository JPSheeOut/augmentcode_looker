view: google_asset_report {
  sql_table_name: `augmentcode.production.google_asset_report` ;;

  dimension_group: date {
    label: ""
    group_label: "- Time Period"
    description: "Advertising platform data is aggregated on the date the ad was shown. For first-party behavioural data, it's aggregated on the date the action/event happened"
    type: time
    timeframes: [
      raw,
      date,
      week,
      day_of_week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }


# START CALCULATED DIMENSION  DEFINITIONS


  dimension: platform {
    label: "Platform"
    description: "Groups data by advertising platforms like Google, Bing, Facebook, LinkedIn, Reddit, Quora, etc."
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: campaign {
    label: "Campaign"
    description: "Campaigns are a set of ad groups of (ads, keywords, bids, offers, regions, etc) that share a budget or objective"
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: ad_group {
    label: "Ad Group"
    description: "Ad groups contains one or more ads that share similar targets, audiences or offers"
    type: string
    sql: ${TABLE}.ad_group ;;
  }

  dimension: asset_level {
    label: "Asset Level"
    description: "Available asset types are account, campaign, ad group and asset"
    type: string
    sql: ${TABLE}.asset_level ;;
  }

  dimension: asset_type {
    label: "Asset Type"
    description: "Available asset types are description, headline, callout, and sitelink"
    type: string
    sql: ${TABLE}.asset_type ;;
  }

  dimension: asset {
    label: "Asset"
    description: "The asset pulled from Google ads"
    type: string
    sql: ${TABLE}.asset ;;
  }

  dimension: region {
    label: "Region"
    description: "Groups data by advertising region. Available regions are nam and other"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: campaign_type {
    label: "Campaign Type"
    description: "Campaign type is derived from the campaign to sort into important types. Available campaign types are brand, foundational, emea, and other"
    type: string
    sql: ${TABLE}.campaign_type ;;
  }



# START MEASURE MODELING


  measure: spend {
    label: "Total Spend"
    description: "The total cost of clicks on your ad when it appeared with the ad asset"
    value_format_name: usd_0
    type: sum
    sql: ${TABLE}.spend ;;
  }

  measure: clicks {
    label: "Total Clicks"
    description: "How many clicks your ad received when it was displayed with a particular asset type. This number combines clicks on the ad headline and on the ad asset, if applicable"
    value_format_name: decimal_0
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: impressions {
    label: "Total Impressions"
    description: "The number of times your ad appeared with the ad asset"
    value_format_name: decimal_0
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: conversions {
    label: "Total Conversions"
    description: "Sums the total number of conversions. An action that's counted when someone interacts with your ad and then takes an action that you’ve defined"
    value_format_name: decimal_0
    type: sum
    sql: ${TABLE}.conversions ;;
  }


# START CALCULATED MEASURE DEFINITIONS


  measure: cpc {
    label: "CPC"
    description: "CPC is the total amount of spend from advertising platforms divided by the number of clicks that your ads receive: spend / clicks = CPC"
    type: number
    value_format_name: usd
    sql: case when ${clicks} = 0 then 0
      else ${spend}/${clicks}
      end;;
  }

  measure: ctr {
    label: "CTR"
    description: "CTR is the number of clicks that your ad receives divided by the number of times your ad is shown: clicks / impressions = CTR"
    type: number
    value_format_name: percent_2
    sql: case when ${impressions} = 0 then 0
      else ${clicks}/${impressions}
      end;;
  }

  measure: cvr{
    label: "CvR"
    description: "Total conversions divided by the total clicks"
    type: number
    value_format_name:  percent_2
    sql: case when ${clicks} = 0 then 0
      else ${conversions}/${clicks}
      end;;
  }

  measure: cp_conversion {
    label: "cpConv"
    description: "Total adverting spend divided by the total number of conversions"
    type: number
    value_format_name: usd_0
    sql: case when ${conversions} = 0 then 0
      else ${spend}/${conversions}
      end;;
  }

}
