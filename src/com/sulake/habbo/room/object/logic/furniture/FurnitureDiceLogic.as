package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureDiceLogic extends FurnitureLogic 
    {

        private var _SafeStr_3182:Boolean = false;
        private var _SafeStr_3183:Boolean = false;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROFCAE_DICE_ACTIVATE", "ROFCAE_DICE_OFF"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.allspritesactivate;
            if (_local_2.length() == 0)
            {
                _SafeStr_3182 = false;
            }
            else
            {
                _SafeStr_3182 = true;
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_3:RoomObjectEvent;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "doubleClick":
                    if (eventDispatcher != null)
                    {
                        if (_SafeStr_3182)
                        {
                            if ((((!(_SafeStr_3183)) || (object.getState(0) == 0)) || (object.getState(0) == 100)))
                            {
                                _local_3 = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_ACTIVATE", object);
                                _SafeStr_3183 = true;
                            }
                            else
                            {
                                _local_3 = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_OFF", object);
                                _SafeStr_3183 = false;
                            };
                        }
                        else
                        {
                            if ((((_arg_1.spriteTag == "activate") || (object.getState(0) == 0)) || (object.getState(0) == 100)))
                            {
                                _local_3 = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_ACTIVATE", object);
                            }
                            else
                            {
                                if (_arg_1.spriteTag == "deactivate")
                                {
                                    _local_3 = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_OFF", object);
                                };
                            };
                        };
                        if (_local_3 != null)
                        {
                            eventDispatcher.dispatchEvent(_local_3);
                        };
                    };
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }


    }
}

