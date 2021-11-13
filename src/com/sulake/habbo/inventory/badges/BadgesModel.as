package com.sulake.habbo.inventory.badges
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import __AS3__.vec.Vector;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
    import flash.events.Event;

    public class BadgesModel implements IInventoryModel 
    {

        public static const BADGES_ALL:int = -1;
        public static const BADGES_INACTIVE:int = 0;
        public static const BADGES_ACTIVE:int = 1;

        private const MAX_ACTIVE_BADGE_COUNT:int = 5;

        private var _controller:HabboInventory;
        private var _SafeStr_570:BadgesView;
        private var _SafeStr_2111:Vector.<Badge>;
        private var _SafeStr_2720:Vector.<Badge>;
        private var _SafeStr_2721:Map;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _disposed:Boolean = false;

        public function BadgesModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary)
        {
            _controller = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_2111 = new Vector.<Badge>(0);
            _SafeStr_2720 = new Vector.<Badge>(0);
            _assets = _arg_4;
            _communication = _arg_3;
            _SafeStr_570 = new BadgesView(this, _arg_2, _arg_4);
            _SafeStr_2721 = new Map();
            initBadgeWindowAsset();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function initBadgeWindowAsset():void
        {
            var _local_2:IAsset = _assets.getAssetByName("inventory_thumb_xml");
            var _local_1:XmlAsset = XmlAsset(_local_2);
            if (Badge._SafeStr_622 == null)
            {
                Badge._SafeStr_622 = (_windowManager.buildFromXML(XML(_local_1.content)) as IWindowContainer);
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (Badge._SafeStr_622 != null)
            {
                Badge._SafeStr_622.dispose();
                Badge._SafeStr_622 = null;
            };
            _disposed = true;
            _controller = null;
            _windowManager = null;
            _SafeStr_2111 = null;
            _SafeStr_2720 = null;
            if (_SafeStr_2721)
            {
                _SafeStr_2721.dispose();
                _SafeStr_2721 = null;
            };
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            _assets = null;
            _communication = null;
        }

        public function requestInitialization():void
        {
            _communication.connection.send(new GetBadgesComposer());
        }

        public function getMaxActiveCount():int
        {
            return (5);
        }

        public function updateView():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.updateAll(null);
            };
        }

        public function updateActionView():void
        {
            _SafeStr_570.updateActionView();
        }

        private function startWearingBadge(_arg_1:Badge):void
        {
            _SafeStr_2720.push(_arg_1);
            _arg_1.isInUse = true;
        }

        private function stopWearingBadge(_arg_1:Badge):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _SafeStr_2720.length)
            {
                if (_SafeStr_2720[_local_2] == _arg_1)
                {
                    _SafeStr_2720.splice(_local_2, 1);
                    _arg_1.isInUse = false;
                    return;
                };
                _local_2++;
            };
        }

        private function resetBadges():void
        {
            if (_SafeStr_2721)
            {
                _SafeStr_2721.dispose();
                _SafeStr_2721 = null;
            };
            if (_SafeStr_2111 != null)
            {
                for each (var _local_1:Badge in _SafeStr_2111)
                {
                    _local_1.dispose();
                };
                _SafeStr_2111 = null;
            };
            if (_SafeStr_2720 != null)
            {
                _SafeStr_2720 = null;
            };
        }

        public function initBadges(_arg_1:Map):void
        {
            var _local_3:int;
            var _local_6:Boolean;
            var _local_5:String;
            var _local_7:String;
            var _local_2:Badge;
            resetBadges();
            _SafeStr_2111 = new Vector.<Badge>(0);
            _SafeStr_2720 = new Vector.<Badge>(0);
            _SafeStr_2721 = new Map();
            for each (var _local_4:String in _arg_1.getKeys())
            {
                _local_3 = _arg_1.getValue(_local_4);
                if (_local_3 > 0)
                {
                    _SafeStr_2721.add(_local_4, _local_3);
                };
                _local_6 = _controller.unseenItemTracker.isUnseen(4, _local_3);
                _local_5 = controller.localization.getBadgeName(_local_4);
                _local_7 = controller.localization.getBadgeDesc(_local_4);
                _local_2 = new Badge(this, _local_4, _local_5, _local_7, _local_6);
                if (_local_6)
                {
                    _SafeStr_2111.unshift(_local_2);
                }
                else
                {
                    _SafeStr_2111.push(_local_2);
                };
            };
        }

        public function updateBadge(_arg_1:String, _arg_2:Boolean, _arg_3:int=0):void
        {
            var _local_7:Boolean;
            var _local_6:String;
            var _local_8:String;
            var _local_4:Badge;
            if (((_arg_3 > 0) && (!(_SafeStr_2721.hasKey(_arg_1)))))
            {
                _SafeStr_2721.add(_arg_1, _arg_3);
            };
            var _local_5:Badge = getBadge(_arg_1);
            if (_local_5 != null)
            {
                if (_local_5.isInUse != _arg_2)
                {
                    if (_arg_2)
                    {
                        startWearingBadge(_local_5);
                    }
                    else
                    {
                        stopWearingBadge(_local_5);
                    };
                };
            }
            else
            {
                _local_7 = _controller.unseenItemTracker.isUnseen(4, _arg_3);
                _local_6 = controller.localization.getBadgeName(_arg_1);
                _local_8 = controller.localization.getBadgeDesc(_arg_1);
                _local_4 = new Badge(this, _arg_1, _local_6, _local_8, _local_7);
                if (_local_7)
                {
                    _SafeStr_2111.unshift(_local_4);
                }
                else
                {
                    _SafeStr_2111.push(_local_4);
                };
                if (_arg_2)
                {
                    startWearingBadge(_local_4);
                };
            };
        }

        private function getBadge(_arg_1:String):Badge
        {
            var _local_3:int;
            var _local_2:Badge;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2111.length)
            {
                _local_2 = _SafeStr_2111[_local_3];
                if (_local_2.badgeId == _arg_1)
                {
                    return (_local_2);
                };
                _local_3++;
            };
            return (null);
        }

        public function removeBadge(_arg_1:String):void
        {
            var _local_3:int;
            var _local_2:Badge;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2111.length)
            {
                _local_2 = _SafeStr_2111[_local_3];
                if (_local_2.badgeId == _arg_1)
                {
                    _SafeStr_2111.splice(_local_3, 1);
                    stopWearingBadge(_local_2);
                    updateView();
                    return;
                };
                _local_3++;
            };
        }

        public function toggleBadgeWearing(_arg_1:String):void
        {
            var _local_2:Badge = getBadge(_arg_1);
            if (_local_2 != null)
            {
                if (_local_2.isInUse)
                {
                    stopWearingBadge(_local_2);
                }
                else
                {
                    startWearingBadge(_local_2);
                };
                saveBadgeSelection();
            };
        }

        public function saveBadgeSelection():void
        {
            var _local_4:int;
            var _local_2:Badge;
            var _local_1:SetActivatedBadgesComposer = new SetActivatedBadgesComposer();
            var _local_3:Vector.<Badge> = getBadges(1);
            _local_4 = 0;
            while (_local_4 < _local_3.length)
            {
                _local_2 = _local_3[_local_4];
                _local_1.addActivatedBadge(_local_2.badgeId);
                _local_4++;
            };
            _communication.connection.send(_local_1);
        }

        public function setBadgeSelected(_arg_1:String):void
        {
            var _local_3:int;
            var _local_2:Badge;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2111.length)
            {
                _local_2 = (_SafeStr_2111[_local_3] as Badge);
                if (_local_2 != null)
                {
                    _local_2.isSelected = (_local_2.badgeId == _arg_1);
                };
                _local_3++;
            };
            updateActionView();
        }

        public function forceSelection():void
        {
            var _local_1:Badge = getSelectedBadge();
            if (_local_1 != null)
            {
                return;
            };
            var _local_3:Vector.<Badge> = getBadges(0);
            if (((!(_local_3 == null)) && (_local_3.length > 0)))
            {
                _local_1 = (_local_3[0] as Badge);
                _local_1.isSelected = true;
                updateView();
                return;
            };
            var _local_2:Vector.<Badge> = getBadges(1);
            if (((!(_local_2 == null)) && (_local_2.length > 0)))
            {
                _local_1 = (_local_2[0] as Badge);
                _local_1.isSelected = true;
                updateView();
            };
        }

        public function getSelectedBadge(_arg_1:int=-1):Badge
        {
            var _local_4:int;
            var _local_3:Badge;
            var _local_2:Vector.<Badge> = getBadges(_arg_1);
            _local_4 = 0;
            while (_local_4 < _local_2.length)
            {
                _local_3 = _local_2[_local_4];
                if (_local_3.isSelected)
                {
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }

        public function getBadges(_arg_1:int=-1):Vector.<Badge>
        {
            var _local_3:Vector.<Badge> = undefined;
            switch (_arg_1)
            {
                case -1:
                    return (_SafeStr_2111);
                case 0:
                    _local_3 = new Vector.<Badge>(0);
                    for each (var _local_2:Badge in _SafeStr_2111)
                    {
                        if (!_local_2.isInUse)
                        {
                            _local_3.push(_local_2);
                        };
                    };
                    return (_local_3);
                case 1:
                    return (_SafeStr_2720);
                default:
                    Logger.log("Unexpected filter. Returning an empty array to maintain backward compatibility");
                    return (new Vector.<Badge>(0));
            };
        }

        public function getBadgeFromActive(_arg_1:int):Badge
        {
            return (getItemInIndex(_arg_1, 1));
        }

        public function getBadgeFromInactive(_arg_1:int):Badge
        {
            return (getItemInIndex(_arg_1, 0));
        }

        public function getItemInIndex(_arg_1:int, _arg_2:int=-1):Badge
        {
            var _local_3:Vector.<Badge> = getBadges(_arg_2);
            if (((_arg_1 < 0) || (_arg_1 >= _local_3.length)))
            {
                return (null);
            };
            return (_local_3[_arg_1]);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (_SafeStr_570.getWindowContainer());
        }

        public function closingInventoryView():void
        {
            if (_SafeStr_570.isVisible)
            {
                resetUnseenItems();
            };
        }

        public function categorySwitch(_arg_1:String):void
        {
            if (((_arg_1 == "badges") && (_controller.isVisible)))
            {
                _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BADGES"));
            };
        }

        public function subCategorySwitch(_arg_1:String):void
        {
        }

        public function get controller():HabboInventory
        {
            return (_controller);
        }

        public function resetUnseenItems():void
        {
            if (!_controller.isMainViewActive)
            {
                return;
            };
            _controller.unseenItemTracker.resetCategory(4);
            for each (var _local_1:Badge in _SafeStr_2111)
            {
                _local_1.isUnseen = false;
            };
            updateView();
            _controller.updateUnseenItemCounts();
        }

        public function selectItemById(_arg_1:String):void
        {
            setBadgeSelected(_arg_1);
        }

        public function removeSelections():void
        {
            for each (var _local_1:Badge in _SafeStr_2111)
            {
                _local_1.isSelected = false;
            };
        }


    }
}

