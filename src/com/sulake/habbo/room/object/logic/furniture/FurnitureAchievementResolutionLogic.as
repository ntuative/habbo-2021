package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureAchievementResolutionLogic extends _SafeStr_111 
    {

        public static const STATE_RESOLUTION_NOT_STARTED:int = 0;
        public static const STATE_RESOLUTION_IN_PROGRESS:int = 1;
        public static const STATE_RESOLUTION_ACHIEVED:int = 2;
        public static const STATE_RESOLUTION_FAILED:int = 3;
        private static const ACH_NOT_SET:String = "ACH_0";
        private static const BADGE_VISIBLE_IN_STATE:Number = 2;


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROWRE_ACHIEVEMENT_RESOLUTION_OPEN", "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING", "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED", "ROGBE_LOAD_BADGE"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_4:RoomObjectEvent;
            super.processUpdateMessage(_arg_1);
            var _local_3:RoomObjectGroupBadgeUpdateMessage = (_arg_1 as RoomObjectGroupBadgeUpdateMessage);
            if (_local_3 != null)
            {
                if (_local_3.assetName != "loading_icon")
                {
                    object.getModelController().setNumber("furniture_badge_visible_in_state", 2);
                };
            };
            var _local_2:RoomObjectSelectedMessage = (_arg_1 as RoomObjectSelectedMessage);
            if (_local_2)
            {
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    if (!_local_2.selected)
                    {
                        _local_4 = new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_FURNI_CONTEXT_MENU", object);
                        eventDispatcher.dispatchEvent(_local_4);
                    };
                };
            };
        }

        override public function useObject():void
        {
            var _local_1:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _local_1 = null;
                switch (object.getState(0))
                {
                    case 0:
                    case 1:
                        _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_OPEN", object);
                        break;
                    case 2:
                        _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING", object);
                        break;
                    case 3:
                        _local_1 = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_FAILED", object);
                    default:
                };
                if (_local_1)
                {
                    eventDispatcher.dispatchEvent(_local_1);
                };
            };
        }

        override protected function updateBadge(_arg_1:String):void
        {
            if (_arg_1 != "ACH_0")
            {
                super.updateBadge(_arg_1);
            };
        }


    }
}

