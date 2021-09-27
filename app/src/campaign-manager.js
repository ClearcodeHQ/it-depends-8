const options = [
  'start_date',
  'end_date',
  'budget',
  'creative_url',
  'target_audience_id',
  'max_bid',
  'compensation_method',
];

module.exports = function(campaignId, lineItemId, campaignConfig) {
  if (campaignId === undefined) {
    console.error(`No campaign ID provided D:`);
    return false;
  }
  
  if (lineItemId === undefined) {
    console.error(`No line item ID provided D:`);
    return false;
  }

  const filteredConfig = {};
  for (const option of options) {
    if (campaignConfig[option] === undefined) {
      console.error(`The ${option} is missing from the config D:`);
      return false;
    }

    filteredConfig[option] = campaignConfig[option];
  }

  // Now imagine, that it's now being sent to some magical
  // (and very important) campaign server (ノ°∀°)ノ⌒･*:.｡. .｡.:*･゜ﾟ･*☆	
  console.log(`Campaign ${campaignId} line item ${lineItemId} updated! :D`);
  return true;
}