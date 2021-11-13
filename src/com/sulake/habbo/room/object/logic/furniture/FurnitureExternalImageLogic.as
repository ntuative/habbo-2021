package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureExternalImageLogic extends FurnitureMultiStateLogic 
    {


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE__STICKIE", "ROFCAE_STICKIE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function get widget():String
        {
            return ("RWE_EXTERNAL_IMAGE");
        }

        override public function initialize(_arg_1:XML):void
        {
            var _local_4:XML;
            var _local_2:String;
            super.initialize(_arg_1);
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:XMLList = _arg_1.mask;
            if (_local_3.length() > 0)
            {
                _local_4 = _local_3[0];
                if (_SafeStr_93.checkRequiredAttributes(_local_4, ["type"]))
                {
                    _local_2 = _local_4.@type;
                    object.getModelController().setNumber("furniture_uses_plane_mask", 1, true);
                    object.getModelController().setString("furniture_plane_mask_type", _local_2, true);
                };
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
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
                    useObject();
                    return;
                default:
                    super.mouseEvent(_arg_1, _arg_2);
                    return;
            };
        }


    }
}

