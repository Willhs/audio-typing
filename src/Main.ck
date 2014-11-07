<<< "Starting Typer Helper" >>>;

me.dir() + "/" => string cwd;
cwd + "action/" => string actions;

Machine.add(cwd + "String.ck");
Machine.add(cwd + "Util.ck");

Machine.add(actions + "Action.ck");

Machine.add(actions + "Insertion.ck");
Machine.add(actions + "LetterAction.ck");
Machine.add(actions + "BigLetterAction.ck");
Machine.add(actions + "DigitAction.ck");
Machine.add(actions + "SymbolAction.ck");
Machine.add(actions + "Deletion.ck");

Machine.add(actions + "Highlight.ck");
Machine.add(actions + "FunctionAction.ck");
Machine.add(actions + "WhitespaceAction.ck");

Machine.add(actions + "Navigation.ck");
Machine.add(actions + "ModifierAction.ck");

Machine.add(cwd + "Config.ck");
Machine.add(cwd + "MultiKeyActionMap.ck");
Machine.add(cwd + "ActionList.ck");
Machine.add(cwd + "Helper.ck");