# Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.

SELECT DISTINCT AH.host_id, AG.guest_id FROM airbnb_hosts AH JOIN airbnb_guests AG ON AH.gender=AG.gender AND AH.nationality=AG.nationality ORDER BY host_id ASC;
