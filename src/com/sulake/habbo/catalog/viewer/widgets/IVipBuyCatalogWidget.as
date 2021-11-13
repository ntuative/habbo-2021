package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;

    public /*dynamic*/ interface IVipBuyCatalogWidget 
    {

        function dispose():void;
        function init():Boolean;
        function reset():void;
        function initClubType(_arg_1:int):void;
        function showOffer(_arg_1:ClubBuyOfferData):void;
        function get isGift():Boolean;

    }
}