procedure TNaosKeyboard.debug(fString :string; clear:boolean=false);
begin
  if(self.z_debug) then
  begin
    if clear then
      ClearDebug();
    fString:=formatDateTime('tt',time())+' | '+ 'Naos_Keyboard ' +' > ' +fString;
    WriteLn(fString);
  end;
end;


procedure TNaosKeyboard.typeString(const s: string; pressEnter: boolean=false; keyWait: integer=50);
begin
  self.debug('typeString > "'+s+ '" > pressEnter > '+toStr(pressEnter)+' > keyWait > '+toStr(keyWait));
  SendKeys(s, keyWait, 0);
  if(pressEnter) then
    PressKey(VK_RETURN);
end;
