const syndicationService = require('../syndicationService');
const mapService = require('../mappers/mapService');

function getService(id) {
  return syndicationService.getService(id).then(mapService);
}

module.exports = getService;
