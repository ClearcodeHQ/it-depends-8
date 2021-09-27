const { Client } = require('pg');
const updateCampaign = require('./campaign-manager');

(async () => {

  const client = new Client();
  await client.connect();

  console.log('App started');

  let lastDateCheck = new Date();
  setInterval(async () => {
    console.log(`Polling DB, last check on ${lastDateCheck.toISOString()}`);
    const res = await client.query(`
      SELECT 
        li.id as line_item_id,
        ca.id as campaign_id,
        li.*, ca.*, cu.*
      FROM line_items li
      LEFT JOIN campaigns ca ON ca.id = li.campaign
      LEFT JOIN customers cu ON cu.id = ca.customer
      WHERE li.last_change > $1 OR ca.last_change > $1
    `, [lastDateCheck.toISOString()]);

    for (const row of res.rows) {
      updateCampaign(
        row['campaign_id'],
        row['line_item_id'],
        {
          start_date: row['start_date'],
          end_date: row['end_date'],
          budget: row['budget'],
          creative_url: row['creative_url'],
          target_audience_id: row['target_audience_id'],
          max_bid: row['max_bid'],
          compensation_method: row['compensation_method'],
        }
      );
    }

    lastDateCheck = new Date();
  }, 1000);

})();
