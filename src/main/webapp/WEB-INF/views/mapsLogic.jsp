<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function openGoogleMaps(userLat, userLng, shopLat, shopLng, shopAddress) {
    var mapsUrl = "";

    // Global Position Parameters Evaluator
    if (userLat && userLng && userLat !== 'null' && userLng !== 'null' && shopLat && shopLng && shopLat !== 'null' && shopLng !== 'null') {
        mapsUrl = "https://www.google.com/maps/dir/?api=1&origin=" + userLat + "," + userLng + "&destination=" + shopLat + "," + shopLng + "&travelmode=driving";
    } 
    // Static Backup Coordinator Fallback
    else if (shopLat && shopLng && shopLat !== 'null' && shopLng !== 'null') {
        mapsUrl = "https://www.google.com/maps/search/?api=1&query=" + shopLat + "," + shopLng;
    } 
    // Content Parsing Router Engine Default Resolver
    else {
        mapsUrl = "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent(shopAddress);
    }

    // Directing Thread to New Active Windows Client 
    window.open(mapsUrl, '_blank');
}
</script>