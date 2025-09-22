@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft Test'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Zjm_R_Draft as select from zjm_draft_test

{

key agency_id as AgencyId,
key travel_id as TravelId,
description as Description,
customer_id as CustomerId,
start_date as StartDate,
end_date as EndDate,
status as Status,
@Semantics.systemDateTime.createdAt: true
created_at as CreatedAt,
@Semantics.user.createdBy: true
created_by as CreatedBy,
@Semantics.systemDateTime.lastChangedAt: true
changed_at as ChangedAt,
@Semantics.user.lastChangedBy: true
changed_by as ChangedBy, 
@Semantics.systemDateTime.localInstanceLastChangedAt: true
loc_changed_at as LocChangedAt    

}
