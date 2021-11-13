package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.camera.CameraWidget;
    import com.sulake.habbo.communication.messages.parser.camera.CameraStorageUrlMessageEvent;
    import com.sulake.habbo.communication.messages.parser.camera.CameraPurchaseOKMessageEvent;
    import com.sulake.habbo.communication.messages.parser.camera.CameraPublishStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.camera.CompetitionStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.camera.InitCameraMessageEvent;
    import com.sulake.habbo.ui.RoomDesktop;
    import com.sulake.habbo.communication.messages.outgoing.camera._SafeStr_50;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.outgoing.camera.PurchasePhotoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.camera.PublishPhotoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.camera.PhotoCompetitionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;

    public class CameraWidgetHandler implements IRoomWidgetHandler, IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:CameraWidget;
        private var _SafeStr_3846:CameraStorageUrlMessageEvent;
        private var _SafeStr_3847:CameraPurchaseOKMessageEvent;
        private var _SafeStr_3848:CameraPublishStatusMessageEvent;
        private var _SafeStr_3849:CompetitionStatusMessageEvent;
        private var _SafeStr_3850:InitCameraMessageEvent;
        private var _roomDesktop:RoomDesktop;
        private var _creditPrice:int = 999;
        private var _ducketPrice:int = 999;
        private var _publishDucketPrice:int = 999;

        public function CameraWidgetHandler(_arg_1:RoomDesktop)
        {
            _roomDesktop = _arg_1;
        }

        public function get creditPrice():int
        {
            return (_creditPrice);
        }

        public function get ducketPrice():int
        {
            return (_ducketPrice);
        }

        public function get publishDucketPrice():int
        {
            return (_publishDucketPrice);
        }

        public function get type():String
        {
            return ("RWE_CAMERA");
        }

        public function get roomDesktop():RoomDesktop
        {
            return (_roomDesktop);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (((_container) && (_container.toolbar)))
            {
                _container.toolbar.events.removeEventListener("HTE_ICON_CAMERA", onCameraRequested);
            };
            _container = _arg_1;
            if (((_container) && (_container.toolbar)))
            {
                _container.toolbar.events.addEventListener("HTE_ICON_CAMERA", onCameraRequested);
            };
            _SafeStr_3846 = new CameraStorageUrlMessageEvent(onCameraStorageUrlEvent);
            _SafeStr_3847 = new CameraPurchaseOKMessageEvent(onPurchaseOK);
            _SafeStr_3848 = new CameraPublishStatusMessageEvent(onPublishStatus);
            _SafeStr_3849 = new CompetitionStatusMessageEvent(onCompetitionStatus);
            _SafeStr_3850 = new InitCameraMessageEvent(onInitCameraEvent);
            _container.connection.addMessageEvent(_SafeStr_3846);
            _container.connection.addMessageEvent(_SafeStr_3847);
            _container.connection.addMessageEvent(_SafeStr_3848);
            _container.connection.addMessageEvent(_SafeStr_3849);
            _container.connection.addMessageEvent(_SafeStr_3850);
        }

        public function sendInitCameraMessage():void
        {
            if (_container.sessionDataManager.isPerkAllowed("CAMERA"))
            {
                _container.connection.send(new _SafeStr_50());
            };
        }

        private function onInitCameraEvent(_arg_1:InitCameraMessageEvent):void
        {
            _creditPrice = _arg_1.getParser().getCreditPrice();
            _ducketPrice = _arg_1.getParser().getDucketPrice();
            _publishDucketPrice = _arg_1.getParser().getPublishDucketPrice();
        }

        private function onPurchaseOK(_arg_1:CameraPurchaseOKMessageEvent):void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.purchaseSuccessful();
            };
        }

        private function onPublishStatus(_arg_1:CameraPublishStatusMessageEvent):void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.publishingStatus(_arg_1);
            };
        }

        private function onCompetitionStatus(_arg_1:CompetitionStatusMessageEvent):void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.competitionStatus(_arg_1);
            };
        }

        private function onCameraStorageUrlEvent(_arg_1:CameraStorageUrlMessageEvent):void
        {
            if (!_SafeStr_1324)
            {
                return;
            };
            var _local_2:String = _arg_1.getParser().url;
            _SafeStr_1324.setRenderedPhotoUrl(_local_2);
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
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
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            if (((_container) && (container.connection)))
            {
                _container.connection.removeMessageEvent(_SafeStr_3846);
                _container.connection.removeMessageEvent(_SafeStr_3847);
                _container.connection.removeMessageEvent(_SafeStr_3848);
                _container.connection.removeMessageEvent(_SafeStr_3849);
                _container.connection.removeMessageEvent(_SafeStr_3850);
            };
            _disposed = true;
            _container = null;
            _roomDesktop = null;
            _SafeStr_1324 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set widget(_arg_1:CameraWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        private function onCameraRequested(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTE_ICON_CAMERA")
            {
                if (_SafeStr_1324)
                {
                    _SafeStr_1324.startTakingPhoto(_arg_1.iconName);
                };
            };
        }

        public function addListenerToStage(_arg_1:String, _arg_2:Function):void
        {
            _roomDesktop.addListenerToStage(_arg_1, _arg_2);
        }

        public function removeListenerFromStage(_arg_1:String, _arg_2:Function):void
        {
            _roomDesktop.removeListenerFromStage(_arg_1, _arg_2);
        }

        public function confirmPhotoPurchase():void
        {
            _container.connection.send(new PurchasePhotoMessageComposer());
        }

        public function confirmPhotoPublish():void
        {
            _container.connection.send(new PublishPhotoMessageComposer());
        }

        public function confirmPhotoCompetitionSubmit():void
        {
            _container.connection.send(new PhotoCompetitionMessageComposer());
        }

        public function collectPhotoData():RenderRoomMessageComposer
        {
            return (_roomDesktop.roomEngine.getRenderRoomMessage(_SafeStr_1324.getViewPort(), _roomDesktop.roomBackgroundColor) as RenderRoomMessageComposer);
        }

        public function sendPhotoData(_arg_1:RenderRoomMessageComposer):void
        {
            _container.connection.send(_arg_1);
        }


    }
}

