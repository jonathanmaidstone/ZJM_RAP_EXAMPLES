@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Draft'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Zjm_C_Draft
  provider contract transactional_query as projection on Zjm_R_Draft
{
    key AgencyId,
    key TravelId,
    Description,
    CustomerId,
    StartDate,
    EndDate,
    Status,
    CreatedAt,
    CreatedBy,
    ChangedAt,
    ChangedBy,
    LocChangedAt
}
