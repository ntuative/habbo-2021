package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
    import flash.display.BitmapData;
    import flash.events.Event;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;

    public class PetPackageFurniWidgetHandler implements IRoomWidgetHandler, IGetImageListener 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1922:int = -1;


        public function get type():String
        {
            return ("RWE_FURNI_PET_PACKAGE_WIDGET");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            return (["RWOPPM_OPEN_PET_PACKAGE"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetOpenPetPackageMessage;
            switch (_arg_1.type)
            {
                case "RWOPPM_OPEN_PET_PACKAGE":
                    _local_2 = (_arg_1 as RoomWidgetOpenPetPackageMessage);
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _container.roomSession.sendOpenPetPackageMessage(_local_2.objectId, _local_2.name);
                    };
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["RSOPPE_OPEN_PET_PACKAGE_REQUESTED", "RSOPPE_OPEN_PET_PACKAGE_RESULT"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_5:RoomSessionPetPackageEvent;
            var _local_3:RoomWidgetPetPackageUpdateEvent;
            var _local_4:BitmapData;
            var _local_6:int;
            var _local_2:int;
            var _local_7:String;
            if (_arg_1 == null)
            {
                return;
            };
            if ((((!(_container == null)) && (!(_container.events == null))) && (!(_arg_1 == null))))
            {
                switch (_arg_1.type)
                {
                    case "RSOPPE_OPEN_PET_PACKAGE_REQUESTED":
                        _local_5 = (_arg_1 as RoomSessionPetPackageEvent);
                        _SafeStr_1922 = _local_5.objectId;
                        _local_4 = getPetImage(_local_5.figureData);
                        _local_6 = ((_local_5.figureData == null) ? -1 : _local_5.figureData.typeId);
                        _local_3 = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED", _SafeStr_1922, _local_4, -1, null, _local_6);
                        _container.events.dispatchEvent(_local_3);
                        return;
                    case "RSOPPE_OPEN_PET_PACKAGE_RESULT":
                        _local_5 = (_arg_1 as RoomSessionPetPackageEvent);
                        _SafeStr_1922 = _local_5.objectId;
                        _local_2 = _local_5.nameValidationStatus;
                        _local_7 = _local_5.nameValidationInfo;
                        _local_3 = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_RESULT", _SafeStr_1922, null, _local_2, _local_7, -1);
                        _container.events.dispatchEvent(_local_3);
                        return;
                };
            };
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
            _SafeStr_1922 = -1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE", _SafeStr_1922, _arg_2, -1, null, -1);
            _container.events.dispatchEvent(_local_3);
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function getPetImage(_arg_1:PetFigureData):BitmapData
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:_SafeStr_147;
            if (_arg_1 != null)
            {
                _local_2 = parseInt(_arg_1.color, 16);
                _local_3 = 0;
                _local_4 = _container.roomEngine.getPetImage(_arg_1.typeId, _arg_1.paletteId, _local_2, new Vector3d(90), 64, this, true, _local_3);
                if (_local_4 != null)
                {
                    return (_local_4.data);
                };
            };
            return (null);
        }


    }
}

