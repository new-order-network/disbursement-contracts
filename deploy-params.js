const endDate = new Date("March 01 2022 00:00:00 UTC");

module.exports = {
  receiver: "0x3257Bde8CF067aE6f1DDc0E4b140fe02e3C5e44f", // The person/project receiving the grant
  wallet: "0x3257Bde8CF067aE6f1DDc0E4b140fe02e3C5e44f", // Wallet allowed to withdraw funds if criteria for the grant is not achieved
  disbursementPeriod: Math.floor(endDate / 1000 - new Date() / 1000),
  startDate: 0, // Starting time for the distribution, (cliff)
  cliffDate: 86400,
  token: "0x6ADa033c7A28152BCD563d0B9a4B1d470fC8716e", // Token used for payout
};
