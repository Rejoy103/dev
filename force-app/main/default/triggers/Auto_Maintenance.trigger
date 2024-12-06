trigger Auto_Maintenance on Case (after update) {
	Auto_Maintenance_helper.createMaintenance(Trigger.New, Trigger.OldMap);
}