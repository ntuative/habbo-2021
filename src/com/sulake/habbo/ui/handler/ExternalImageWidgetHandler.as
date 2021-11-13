package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.externalimage.ExternalImageWidget;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.room.object.IRoomObject;
    import flash.events.Event;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ExternalImageWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _SafeStr_1324:ExternalImageWidget;


        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set widget(_arg_1:ExternalImageWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            return (null);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["ROSM_USE_PRODUCT_FROM_INVENTORY"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomEngineUseProductEvent;
            if (_container.roomEngine == null)
            {
                return;
            };
            if ((_arg_1 is RoomEngineUseProductEvent))
            {
                _local_2 = (_arg_1 as RoomEngineUseProductEvent);
                if (_local_2.type == "ROSM_USE_PRODUCT_FROM_INVENTORY")
                {
                    _SafeStr_1324.showWithFurniID(_local_2.objectId);
                };
            };
            var _local_4:RoomEngineToWidgetEvent = (_arg_1 as RoomEngineToWidgetEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:IRoomObject = _container.roomEngine.getRoomObject(_local_4.roomId, _local_4.objectId, _local_4.category);
            switch (_arg_1.type)
            {
                case "RETWE_OPEN_WIDGET":
                    if (_local_3 != null)
                    {
                        _SafeStr_1324.showWithRoomObject(_local_3);
                    };
                    return;
                case "RETWE_CLOSE_WIDGET":
                    _SafeStr_1324.hide();
                    return;
            };
        }

        public function deleteCard(_arg_1:int):void
        {
            if (((!(_container == null)) && (!(_container.roomEngine == null))))
            {
                _container.roomEngine.deleteRoomObject(_arg_1, 20);
            };
        }

        public function isRoomOwner():Boolean
        {
            return (_container.roomSession.isRoomOwner);
        }

        public function hasRightsToRemove():Boolean
        {
            return (_container.roomSession.roomControllerLevel >= 4);
        }

        public function sendMessage(_arg_1:IMessageComposer):void
        {
            _container.connection.send(_arg_1);
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            _container = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_EXTERNAL_IMAGE");
        }

        public function get storiesImageUrlBase():String
        {
            return (_container.config.getProperty("stories.image_url_base"));
        }

        public function get storiesImageShareUrl():String
        {
            return (_container.config.getProperty("stories.image.sharing_url_base"));
        }

        public function get extraDataServiceUrl():String
        {
            return (_container.config.getProperty("extra_data_service_url"));
        }

        public function isSelfieReportingEnabled():Boolean
        {
            return (_container.config.getProperty("stories.report.selfie.enabled") == "true");
        }


    }
}

