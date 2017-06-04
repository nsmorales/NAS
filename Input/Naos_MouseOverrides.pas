(*
  MOUSE_RIGHT = 0
  MOUSE_LEFT = 1
  MOUSE_MIDDLE = 2
*)

Var
  Naos_LastX, Naos_LastY: integer;

procedure GetMousePos(var x,y: Int32); override
begin
  x:=Naos_LastX;
  y:=Naos_LastY;
end;

procedure MoveMouse(x, y: Int32); override;
begin
  Naos_LastX:=x;
  Naos_LastY:=y;
  User32.PostMessage(Naos.getGameClient(), WM_MOUSEMOVE, $00000000, MAKELPARAM(x, y));
end;

procedure ClickMouse(x, y, clickType: Int32); override;
begin
  Naos_LastX:=x;
  Naos_LastY:=y;
  case clickType of
  0: clickType := WM_RBUTTONDOWN;
  1: clickType := WM_LBUTTONDOWN;
  2: clickType := WM_MBUTTONDOWN;
  end;
  User32.PostMessage(Naos.getGameClient(), clickType, $00000001, MAKELPARAM(x, y)); //Down
  sleep(20);
  User32.PostMessage(Naos.getGameClient(), clickType+1, $00000000, MAKELPARAM(x, y)); //Up
end;


(*
  Notes:
    Scrolls at the given x/y, it does 'move' the mouse, but unreliable
    Use Negative for Down scrolling, Positive for Upward.
    EX: -1 will scroll down one 'click', 2 will scroll up two 'clicks'
*)

procedure ScrollMouse(x, y: Integer; Clicks: Integer); override
begin
  Naos_LastX:=x;
  Naos_LastY:=y;
  User32.PostMessage(Naos.getGameClient(), $020A, MAKEWPARAM(0, Clicks*120), MAKELPARAM(x, y)); //Down
end;

(*
  MOUSE_RIGHT = 0
  MOUSE_LEFT = 1
  MOUSE_MIDDLE = 2
*)

(*
  Notes:
    Does 'move' the mouse, but can be unreliable
*)
procedure HoldMouse(x, y: integer; clickType: integer); override;
begin
  Naos_LastX:=x;
  Naos_LastY:=y;
  case clickType of
  0: clickType := WM_RBUTTONDOWN;
  1: clickType := WM_LBUTTONDOWN;
  2: clickType := WM_MBUTTONDOWN;
  end;
  User32.PostMessage(Naos.getGameClient(), WM_MOUSEMOVE, $00000000, MAKELPARAM(x, y));
  sleep(20);
  User32.PostMessage(Naos.getGameClient(), clickType, $00000001, MAKELPARAM(x, y)); //Down
end;

(*
  Notes:
    Does 'move' the mouse, but can be unreliable
*)
procedure ReleaseMouse(x, y: integer; clickType: integer); override;
begin
  Naos_LastX:=x;
  Naos_LastY:=y;
  case clickType of
  0: clickType := WM_RBUTTONDOWN;
  1: clickType := WM_LBUTTONDOWN;
  2: clickType := WM_MBUTTONDOWN;
  end;
  User32.PostMessage(Naos.getGameClient(), WM_MOUSEMOVE, $00000000, MAKELPARAM(x, y));
  sleep(20);
  User32.PostMessage(Naos.getGameClient(), clickType+1, $00000000, MAKELPARAM(x, y)); //Up
end;
