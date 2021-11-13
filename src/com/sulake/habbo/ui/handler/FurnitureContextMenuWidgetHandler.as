package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxToolbarExtension;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.GuildFurniContextMenuInfoMessageEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageParser;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;

    public class FurnitureContextMenuWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _widget:FurnitureContextMenuWidget;
        private var _connection:IConnection;
        private var _SafeStr_3864:IMessageEvent = null;
        private var _mysteryBoxToolbarExtension:MysteryBoxToolbarExtension;

        public function FurnitureContextMenuWidgetHandler()
        {
            _mysteryBoxToolbarExtension = new MysteryBoxToolbarExtension(this);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_mysteryBoxToolbarExtension != null)
                {
                    _mysteryBoxToolbarExtension.dispose();
                    _mysteryBoxToolbarExtension = null;
                };
                unsetContainer();
                if (((!(_connection == null)) && (_SafeStr_3864)))
                {
                    _connection.removeMessageEvent(_SafeStr_3864);
                    _SafeStr_3864 = null;
                };
                _connection = null;
                _widget = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return (null);
        }

        public function get roomEngine():IRoomEngine
        {
            return ((_container) ? _container.roomEngine : null);
        }

        private function unsetContainer():void
        {
            if (_container != null)
            {
                _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG", onMonsterPlantSeedPlantConfirmationDialogRequested);
                _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG", onPurchasableClothingConfirmationDialogRequested);
                _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG", onMysteryBoxOpenDialogRequested);
                _container.roomEngine.events.removeEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG", onEffectBoxOpenDialogRequested);
                _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG", onMysteryTrophyOpenDialogRequested);
            };
            _container = null;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            unsetContainer();
            _container = _arg_1;
            if (_arg_1 == null)
            {
                return;
            };
            if (_container.roomEngine != null)
            {
                _container.roomEngine.events.addEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG", onMonsterPlantSeedPlantConfirmationDialogRequested);
                _container.roomEngine.events.addEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG", onPurchasableClothingConfirmationDialogRequested);
                _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG", onMysteryBoxOpenDialogRequested);
                _container.roomEngine.events.addEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG", onEffectBoxOpenDialogRequested);
                _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG", onMysteryTrophyOpenDialogRequested);
            };
        }

        public function set widget(_arg_1:FurnitureContextMenuWidget):void
        {
            _widget = _arg_1;
            if (_container.config.getBoolean("mysterybox.tracker.active"))
            {
                _mysteryBoxToolbarExtension.createWindow();
            };
        }

        public function set connection(_arg_1:IConnection):void
        {
            _connection = _arg_1;
            if (!_SafeStr_3864)
            {
                _SafeStr_3864 = new GuildFurniContextMenuInfoMessageEvent(onGuildFurniContextMenuInfo);
                _connection.addMessageEvent(_SafeStr_3864);
            };
        }

        public function get roomSession():IRoomSession
        {
            return ((_container) ? _container.roomSession : null);
        }

        public function getFurniData(_arg_1:IRoomObject):IFurnitureData
        {
            var _local_2:IFurnitureData;
            var _local_3:int;
            if (_arg_1)
            {
                _local_3 = _arg_1.getModel().getNumber("furniture_type_id");
                _local_2 = _container.sessionDataManager.getFloorItemData(_local_3);
            };
            return (_local_2);
        }

        public function getWidgetMessages():Array
        {
            return (["RWUPM_MONSTERPLANT_SEED"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetUseProductMessage;
            if (!_arg_1)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWUPM_MONSTERPLANT_SEED":
                    _local_2 = (_arg_1 as RoomWidgetUseProductMessage);
                    if (_local_2)
                    {
                        _container.roomSession.plantSeed(_local_2.roomObjectId);
                    };
                    break;
                default:
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["RETWE_OPEN_FURNI_CONTEXT_MENU", "RETWE_CLOSE_FURNI_CONTEXT_MENU"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            if (_widget == null)
            {
                return;
            };
            var _local_3:RoomEngineToWidgetEvent = (_arg_1 as RoomEngineToWidgetEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:IRoomObject = getRoomObject(_local_3.objectId);
            if (_local_2 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RETWE_OPEN_FURNI_CONTEXT_MENU":
                    switch (_local_3.contextMenu)
                    {
                        case "FRIEND_FURNITURE":
                            _widget.showFriendFurnitureContextMenu(_local_2);
                            break;
                        case "MONSTERPLANT_SEED":
                            if (_container.isOwnerOfFurniture(_local_2))
                            {
                                _widget.showMonsterPlantSeedContextMenu(_local_2, _local_3.category);
                            };
                            break;
                        case "MYSTERY_BOX":
                            _widget.showMysteryBoxContextMenu(_local_2);
                            break;
                        case "RANDOM_TELEPORT":
                            _widget.showRandomTeleportContextMenu(_local_2, _local_3.category);
                            break;
                        case "PURCHASABLE_CLOTHING":
                            _widget.showUsableFurnitureContextMenu(_local_2, _local_3.category);
                    };
                    return;
                case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
                    _widget.hideContextMenu(_local_2);
                    return;
            };
        }

        public function update():void
        {
        }

        public function getObjectRectangle(_arg_1:int):Rectangle
        {
            return (_container.roomEngine.getRoomObjectBoundingRectangle(_container.roomSession.roomId, _arg_1, 10, _container.getFirstCanvasId()));
        }

        public function getObjectScreenLocation(_arg_1:int):Point
        {
            return (_container.roomEngine.getRoomObjectScreenLocation(_container.roomSession.roomId, _arg_1, 10, _container.getFirstCanvasId()));
        }

        public function sendGoToHomeRoomMessage(_arg_1:int):void
        {
            _container.navigator.goToPrivateRoom(_arg_1);
        }

        public function sendJoinToGroupMessage(_arg_1:int):void
        {
            _connection.send(new JoinHabboGroupMessageComposer(_arg_1));
        }

        private function getRoomObject(_arg_1:int):IRoomObject
        {
            if (_container == null)
            {
                return (null);
            };
            return (_container.roomEngine.getRoomObject(_container.roomSession.roomId, _arg_1, 10));
        }

        private function onGuildFurniContextMenuInfo(_arg_1:GuildFurniContextMenuInfoMessageEvent):void
        {
            var _local_2:GuildFurniContextMenuInfoMessageParser;
            var _local_3:IRoomObject;
            if (_widget != null)
            {
                _local_2 = _arg_1.getParser();
                _local_3 = getRoomObject(_local_2.objectId);
                if (_local_3 != null)
                {
                    _widget.showGuildFurnitureContextMenu(_local_3, _local_2.guildId, _local_2.guildName, _local_2.guildHomeRoomId, _local_2.userIsMember, _local_2.guildHasReadableForum);
                };
            };
        }

        private function onMonsterPlantSeedPlantConfirmationDialogRequested(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_2:Boolean;
            if (_widget != null)
            {
                _local_3 = getRoomObject(_arg_1.objectId);
                if (_local_3 != null)
                {
                    _local_2 = _container.isOwnerOfFurniture(_local_3);
                    if (!_local_2)
                    {
                        return;
                    };
                    _widget.showPlantSeedConfirmationDialog(_local_3);
                };
            };
        }

        private function onPurchasableClothingConfirmationDialogRequested(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_2:Boolean;
            if (_widget != null)
            {
                _local_3 = getRoomObject(_arg_1.objectId);
                if (_local_3 != null)
                {
                    _local_2 = _container.isOwnerOfFurniture(_local_3);
                    if (!_local_2)
                    {
                        return;
                    };
                    _widget.showPurchasableClothingConfirmationDialog(_local_3);
                };
            };
        }

        private function onEffectBoxOpenDialogRequested(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_2:Boolean;
            if (_widget != null)
            {
                _local_3 = getRoomObject(_arg_1.objectId);
                if (_local_3 != null)
                {
                    _local_2 = _container.isOwnerOfFurniture(_local_3);
                    if (!_local_2)
                    {
                        return;
                    };
                    _widget.showEffectBoxOpenDialog(_local_3);
                };
            };
        }

        private function onMysteryTrophyOpenDialogRequested(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_2:Boolean;
            if (_widget != null)
            {
                _local_3 = getRoomObject(_arg_1.objectId);
                if (_local_3 != null)
                {
                    _local_2 = _container.isOwnerOfFurniture(_local_3);
                    if (!_local_2)
                    {
                        return;
                    };
                    _widget.showMysteryTrophyOpenDialog(_local_3);
                };
            };
        }

        private function onMysteryBoxOpenDialogRequested(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IRoomObject;
            if (_widget != null)
            {
                _local_2 = getRoomObject(_arg_1.objectId);
                if (_local_2 != null)
                {
                    _widget.showMysteryBoxOpenDialog(_local_2);
                };
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function get widget():FurnitureContextMenuWidget
        {
            return (_widget);
        }


    }
}

