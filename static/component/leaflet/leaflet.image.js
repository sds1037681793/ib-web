! function(a, b, c) {
    var d = "ImageMap",
        e = {
            "Draw:enable": [],
            "Save:enable": [],
            "Save:before": [],
            "Save:after": [],
            "Draw:before": [],
            "Draw:after": [],
            "Delete:enable": [],
            "Delete:before": [],
            "Delete:after": []
        };
    ! function() {
        var a = L.Draw.Polygon.prototype.addVertex,
            b = {
                addVertex: function(b) {
                    var c = this._markers.length;
                    if (c > 1) {
                        var d = {
                            hasError: !1,
                            err: ""
                        };
                        if (this._map.fire("draw:addpoint", {
                                layer: this._markers,
                                point: b,
                                cdata: d
                            }), d.hasError) return void this._showAcrossErrorMsg(d.err)
                    }
                    a.call(this, b)
                },
                _showAcrossErrorMsg: function(a) {
                    this._errorShown = !0, this._tooltip.showAsError().updateContent({
                        text: a
                    }), this._updateGuideColor(this.options.drawError.color), this._poly.setStyle({
                        color: this.options.drawError.color
                    }), this._clearHideErrorTimeout(), this._hideErrorTimeout = setTimeout(L.Util.bind(this._hideErrorTooltip, this), this.options.drawError.timeout)
                }
            };
        L.Draw.Polygon.include(b)
    }(),
    function() {
        var a = {
            _showText: !0,
            _textSize: 22,
            setTextShow: function(a) {
                this._showText = a
            },
            getTextShow: function() {
                return this._showText
            },
            setTextSize: function(a) {
                this._textSize = a
            },
            getTextSize: function() {
                return this._textSize
            }
        };
        L.Map.include(a)
    }(),
    function() {
        var a = L.Polygon.prototype.onAdd,
            b = L.Polyline.prototype.onRemove,
            d = L.Polyline.prototype._updatePath,
            e = L.Polyline.prototype.bringToFront,
            f = {
                _customData: {},
                setData: function(a) {
                    this._customData = a
                },
                getData: function() {
                    return this._customData
                },
                getCenter: function() {
                    var a = this.getLatLngs(),
                        b = a.length,
                        c = 0,
                        d = 0;
                    for (var e in a) c += a[e].lat, d += a[e].lng;
                    return [c / b, d / b]
                },
                getWidthAndHeight: function() {
                    var a = this.getBounds(),
                        b = {
                            width: 0,
                            height: 0
                        };
                    return b.width = a.getEast() - a.getWest(), b.height = a.getNorth() - a.getSouth(), b
                },
                onAdd: function(b) {
                    a.call(this, b), this._textRedraw()
                },
                onRemove: function(a) {
                    a = a || this._map, a && this._textNode && a.removeLayer(this._textNode), b.call(this, a)
                },
                bringToFront: function() {
                    e.call(this), this._textRedraw()
                },
                _updatePath: function() {
                    d.call(this), this._textRedraw()
                },
                _textRedraw: function() {
                    var a = this._text,
                        b = this._textOptions;
                    a && this.setText(null).setText(a, b)
                },
                setText: function(a, b) {
                    if (this._text = a, this._textOptions = b, !L.Browser.svg || "undefined" == typeof this._map) return this;
                    var d = {
                        repeat: !1,
                        fillColor: "black",
                        attribute: {},
                        below: !1
                    };
                    if (b = L.Util.extend(d, b), !a) return this._textNode && this._textNode.parentNode && (this._container.removeChild(this._textNode), this._container.removeChild(this._textRect), delete this._textNode), this;
                    if (this._map.getTextShow()) {
                        var e = this._map.getTextSize();
                        e || (e = 1), a = a.replace(/ /g, " ");
                        var f = this._map.getZoom() + 1,
                            g = this._container,
                            h = this._path,
                            i = L.Path.prototype._createElement("text"),
                            j = h.pathSegList,
                            k = {
                                x: 0,
                                y: 0
                            };
                        try {
                            if ("undefined" != typeof j) {
                                for (var l = 0; l < j.numberOfItems; l++) "Z" != j.getItem(l).pathSegTypeAsLetter.toUpperCase() && (isNaN(j.getItem(l).x) || isNaN(j.getItem(l).y) || (k.x += j.getItem(l).x, k.y += j.getItem(l).y));
                                if (j.numberOfItems <= 1) return this;
                                k.x /= j.numberOfItems - 1, k.y /= j.numberOfItems - 1
                            } else if ("undefined" != typeof h.getBBox) {
                                var m = h.getBBox();
                                k.x = m.x + m.width / 2, k.y = m.y + m.height / 2
                            }
                        } catch (n) {
                            console.error(n.toString())
                        }

                        i.setAttribute("text-anchor", "middle"), i.setAttribute("x", k.x), i.setAttribute("y", k.y), i.setAttribute("y", k.y), i.setAttribute("font-size", f * e + "px"), i.appendChild(c.createTextNode(a)), this._textNode = i, g.appendChild(i);
                        var o = c.createElementNS("http://www.w3.org/2000/svg", "rect");
                        try {
                            var p = i.getBBox();
                            o.setAttribute("x", p.x), o.setAttribute("y", p.y), o.setAttribute("width", p.width), o.setAttribute("height", p.height), o.setAttribute("fill", "white")
                        } catch (n) {}
                        g.insertBefore(o, i), this._textRect = o
                    }
                }
            };
        L.Polygon.include(f)
    }(),
    function() {
        var a = L.Control.extend({
            options: {
                position: "topleft",
                buttons: []
            },
            _createButton: function(a, b, c, d) {
                var e = L.DomUtil.create("a", "leaflet-control-zoom-in " + a, c);
                e.innerHTML = b, e.setAttribute("href", "#"), L.DomEvent.on(e, "click", L.DomEvent.stopPropagation).on(e, "mousedown", L.DomEvent.stopPropagation).on(e, "dblclick", L.DomEvent.stopPropagation).on(e, "click", L.DomEvent.preventDefault).on(e, "click", d)
            },
            onAdd: function() {
                var a = L.DomUtil.create("div", "leaflet-bar leaflet-control");
                for (var b in this.options.buttons) {
                    var c = this.options.buttons[b];
                    this._createButton(c.className, c.text, a, c.callback)
                }
                return a
            }
        });
        L.CustomControl = a
    }();
    var f, g = L.Popup.extend({
            initialize: function(a) {
                L.setOptions(this, a);
                var b = L.DomUtil.create("div", "command");
                b.innerHTML = "<button class=\"btn btn-default btn-input\">删除</button>", this.setContent(b)
            }
        }),
        h = {
            maxWidth: 1200,
            maxHeight: 960,
            mapMinZoom: 0,
            mapMaxZoom: 3,
            editable: !0,
            opacity: 1,
            preventAcross: !1
        },
        i = !0,
        j = function(b, c) {
            L.drawLocal.draw.toolbar.buttons.polygon = "点击绘制多边形区域", L.drawLocal.draw.toolbar.buttons.rectangle = "点击绘制长方形区域", L.drawLocal.draw.toolbar.actions.text = "取消", L.drawLocal.draw.toolbar.undo.text = "删除最近一个节点", L.drawLocal.draw.handlers.polygon.tooltip.start = "点击位置开始添加多边形区域", L.drawLocal.draw.handlers.polygon.tooltip.cont = "点选位置继续添加多边形区域的节点", L.drawLocal.draw.handlers.polygon.tooltip.end = "点选位置继续添加节点或者点击开始节点完成绘制", L.drawLocal.draw.handlers.rectangle.tooltip.start = "左键点击并长按拖动来添加长方形区域", L.drawLocal.draw.handlers.simpleshape.tooltip.end = "拖动后释放左键完成绘制", f = this, this.initProperties(), this.initOptions(c), this.$map = L.map(b, {
                attributionControl: !1,
                maxZoom: this.options.mapMaxZoom,
                minZoom: this.options.mapMinZoom,
                scrollWheelZoom: !1,
                crs: L.CRS.Simple,
                dragging: !0,
                noWrap: !0
            }).setView([0, 0], this.options.mapMinZoom), this.$map.addLayer(this.drawnItems);
            var d = [
                [0, this.options.maxWidth],
                [this.options.maxHeight, 0]
            ];
            return this.$map.fitBounds(d), this.options.editable && this.initToolbar(), this.addActions(), this.addInfoControl(), {
                options: this.options,
                init: a.proxy(this.init, this),
                map: this.$map,
                drawnItems: this.drawnItems,
                setImage: a.proxy(this.setImage, this),
                getPolygonArrayList: a.proxy(this.getPolygonArrayList, this),
                addPolygon: a.proxy(this.addPolygon, this),
                getPolygonList: a.proxy(this.getPolygonList, this),
                bind: a.proxy(this.bind, this),
                unbind: a.proxy(this.unbind, this),
                unbindAll: a.proxy(this.unbindAll, this),
                getEnableDraw: a.proxy(this.getEnableDraw, this),
                removeShape: a.proxy(this._removeShape, this),
                initSetting: a.proxy(this.initSetting, this),
                drawControl: this.drawControl,
                triggerDraw: a.proxy(this.triggerDraw, this),
                isEditing: a.proxy(this.isEditing, this),
                moveLayer: a.proxy(this.moveLayer, this),
                moveLayers: a.proxy(this.moveLayers, this)
            }
        };
    j.prototype.getEnableDraw = function() {
        return i
    }, j.prototype.initProperties = function() {
        this.bgImage = {}, this.drawnItems = new L.FeatureGroup
    }, j.prototype.initOptions = function(b) {
        this.options = {}, this.options = a.extend(h, b)
    }, j.prototype.setImage = function(b) {
        var d = c.createElement("img"),
            e = this;
        a(d).load(function(c) {
            var d = e.$map.getPixelBounds(),
                f = (d.max.y - d.min.y, d.max.x - d.min.x, c.target.width / c.target.height),
                g = d.max.x - d.min.x,
                h = g / f;
            a(e.$map._container).height(h + "px"), e.bgImage && e.$map.removeLayer(e.bgImage), e.$map.fitBounds([
                [0, g],
                [h, 0]
            ]), e.$map.setMaxBounds([
                [0, g],
                [h, 0]
            ]), e.$map.invalidateSize(!1).setView([g / 2, h / 2]), e.bgImage = L.imageOverlay(b, [
                [0, g],
                [h, 0]
            ]), e.bgImage.addTo(e.$map), e.bgImage.bringToBack()
        }).attr("src", b)
    }, j.prototype.initToolbar = function() {
        this.drawControl = new L.Control.Draw({
            draw: {
                polygon: {
                    allowIntersection: !1,
                    shapeOptions: {
                        weight: 2
                    }
                },
                marker: !1,
                polyline: !1,
                rectangle: {
                    allowIntersection: !1,
                    shapeOptions: {
                        weight: 2
                    }
                },
                circle: !1,
                marker: !1
            },
            edit: {
                featureGroup: this.drawnItems,
                edit: !0,
                remove: !1
            }
        });
        var b = 10;
        this.textControl = new L.CustomControl({
            buttons: [{
                className: "",
                text: "A",
                callback: function() {
                    f.$map.setTextShow(!f.$map.getTextShow()), a.each(f.drawnItems.getLayers(), function(a, b) {
                        b.redraw()
                    })
                }
            }, {
                className: "",
                text: "A+",
                callback: function() {
                    var c = f.$map.getTextSize();
                    f.$map.setTextSize(c + b), a.each(f.drawnItems.getLayers(), function(a, b) {
                        b.redraw()
                    })
                }
            }, {
                className: "",
                text: "A-",
                callback: function() {
                    var c = f.$map.getTextSize();
                    b >= c || (f.$map.setTextSize(c - b), a.each(f.drawnItems.getLayers(), function(a, b) {
                        b.redraw()
                    }))
                }
            }]
        }), this.$map.addControl(this.drawControl), this.$map.addControl(this.textControl)
    };
    var k = {
            fillOpacity: .75
        },
        l = {},
        m = function(a) {
            var b = a.target;
            l.fillOpacity = b._path.getAttribute("fill-opacity"), l.fillOpacity = .5, b.setStyle(k), b.bringToFront()
        },
        n = function(a) {
            var b = a.target;
            b.setStyle(l)
        };
    j.prototype.addActions = function() {
        var b = this;
        this.drawnItems.on("layeradd", function(c) {
            var d = c.layer;
            if (b.options.editable) {
                var e = new g;
                b.drawControl.setDrawingOptions({
                    polygon: {
                        shapeOptions: {
                            weight: 2,
                            color: b._getColor(),
                            opacity: 1
                        }
                    },
                    rectangle: {
                        shapeOptions: {
                            weight: 2,
                            color: b._getColor(),
                            opacity: 1
                        }
                    }
                }), d.on("contextmenu", function(c) {
                    e.setLatLng(c.latlng), e.openOn(b.$map), a(e._container).find("button").click(function() {
                        b.drawnItems.removeLayer(d), b.$map.removeLayer(e), b._removeShape(d)
                    })
                })
            }
            d.on({
                mouseover: m,
                mouseout: n
            })
        }), this.drawnItems.on("layerremove", function(a) {
            var c = a.layer;
            b._trigger("Delete:after", [b.$map, c])
        }), b.$map.on("draw:drawstart", function(a) {
            a.layer
        }), b.$map.on("draw:addpoint", function() {}), b.$map.on("draw:created", function(a) {
            var c = (a.layerType, a.layer);
            b._triggerEnable("Save:enable", [b.$map, c]) && (b._trigger("Save:before", [b.$map, c]), b.drawnItems.addLayer(c), b._trigger("Save:after", [b.$map, c]))
        })
    }, j.prototype.bind = function(a, b) {
        return e[a] ? void e[a].push(b) : void console.error("Bind Error:Unknown event " + a)
    }, j.prototype.unbind = function(a, b) {
        if (!e[a]) return void console.error("Unbind Error:Unknown event " + a);
        for (var c in e[a])
            if (e[a][c] == b) {
                e[a] = e[a].splice(c, 1);
                break
            }
    }, j.prototype.unbindAll = function(a) {
        return e[a] ? void(e[a] = []) : void console.error("Unbind Error:Unknown event " + a)
    }, j.prototype._trigger = function(a, b) {
        if (!e[a]) return void console.error("Run Error:Unknown event " + a);
        for (var c in e[a]) "function" == typeof e[a][c] && e[a][c].apply(this, b)
    }, j.prototype._triggerEnable = function(a, b) {
        if (!e[a]) return void console.error("Run Error:Unknown event " + a);
        for (var c in e[a])
            if ("function" == typeof e[a][c] && !e[a][c].apply(this, b)) return console.error("Run Stop on " + a), !1;
        return !0
    }, j.prototype._removeShape = function(a) {
        this.drawnItems.removeLayer(a)
    }, j.prototype.getPolygonArrayList = function() {
        var a = this.getPolygonList(),
            b = [];
        for (var c in a) {
            var d = {
                    location: [],
                    data: {}
                },
                e = a[c].getLatLngs();
            for (var f in e) d.location.push(this._LatLng2Array(e[f]));
            d.data = a[c].getData(), b.push(d)
        }
        return b
    }, j.prototype.addPolygon = function(a, b, c) {
        var d = L.polygon(a, {
            weight: 2,
            color: this._getColor()
        });

        d.setText(b), d.setData(c), this.drawnItems.addLayer(d)
    }, j.prototype.getPolygonList = function() {
        return this.drawnItems.getLayers()
    }, j.prototype._LatLng2Array = function(a) {
        var b = [];
        return b[0] = a.lng, b[1] = a.lat, b
    }, j.prototype._LatLng2CPoint = function(a) {
        return new CPoint(a.lng, a.lat)
    };
    var o = ["#7fffd4", "#0000ff", "#8a2be2", "#a52a2a", "#deb887", "#5f9ea0", "#7fff00", "#d2691e", "#ff7f50", "#6495ed", "#dc143c", "#00ffff", "#00008b", "#008b8b", "#b8860b", "#a9a9a9", "#006400", "#bdb76b", "#8b008b", "#556b2f", "#ff8c00", "#9932cc", "#8b0000", "#e9967a", "#8fbc8f", "#483d8b", "#2f4f4f", "#00ced1", "#9400d3", "#ff1493", "#00bfff", "#696969", "#1e90ff", "#b22222", "#228b22", "#ff00ff", "#ffd700", "#daa520", "#808080", "#008000", "#adff2f", "#ff69b4", "#cd5c5c", "#4b0082", "#f0e68c", "#7cfc00", "#add8e6", "#f08080", "#d3d3d3", "#90ee90", "#ffb6c1", "#ffa07a", "#20b2aa", "#87cefa", "#778899", "#b0c4de", "#00ff00", "#32cd32", "#ff00ff", "#800000", "#66cdaa", "#0000cd", "#ba55d3", "#9370d8", "#3cb371", "#7b68ee", "#00fa9a", "#48d1cc", "#c71585", "#191970", "#ffe4e1", "#ffdead", "#000080", "#808000", "#6b8e23", "#ffa500", "#ff4500", "#da70d6", "#98fb98", "#afeeee", "#d87093", "#ffdab9", "#cd853f", "#ffc0cb", "#dda0dd", "#b0e0e6", "#800080", "#ff0000", "#bc8f8f", "#4169e1", "#8b4513", "#fa8072", "#f4a460", "#2e8b57", "#a0522d", "#c0c0c0", "#87ceeb", "#6a5acd", "#708090", "#00ff7f", "#4682b4", "#d2b48c", "#008080", "#d8bfd8", "#ff6347", "#40e0d0", "#ee82ee", "#f5deb3", "#9acd32"],
        p = -1;
    j.prototype._getColor = function() {
        return p++, p %= o.length, o[p]
    }, j.prototype.initSetting = function() {
        p = -1
    }, j.prototype.addInfoControl = function() {}, j.prototype.triggerDraw = function(b) {
        var c = this.drawControl._toolbars.draw._modes;
        "polygon" == b ? (a(c.polygon.button).mousedown(), c.polygon.button.click()) : "rectangle" == b && (a(c.rectangle.button).mousedown(), c.rectangle.button.click())
    }, j.prototype.isEditing = function() {
        return this.drawControl._toolbars.edit.enabled()
    }, j.prototype.moveLayer = function(a, b, c) {
        var d = a.getLatLngs();
        for (var e in d) d[e].lat += b, d[e].lng += c;
        a.setLatLngs(d)
    }, j.prototype.moveLayers = function(a, b) {
        for (var c in this.drawnItems._layers) {
            var d = this.drawnItems._layers[c];
            this.moveLayer(d, a, b)
        }
    }, a[d] = function(a, b) {
        return new j(a, b)
    }
}(jQuery, window, document), L.CustomUtils = function() {
    function a(a, b) {
        this.x = a, this.y = b
    }
    var b = {};
    return b.CPoint = a, b.LatLng2CPoint = function(b) {
        return new a(b.lng, b.lat)
    }, b.Polygon2PointList = function(a) {
        latlngList = a.getLatLngs(), result = [];
        for (var b in latlngList) result.push(this.LatLng2CPoint(latlngList[b]));
        return result
    }, b.DetectSegmentAcross = function(a, b, c, d) {
        var e = (a.x - c.x) * (b.y - c.y) - (a.y - c.y) * (b.x - c.x),
            f = (a.x - d.x) * (b.y - d.y) - (a.y - d.y) * (b.x - d.x);
        if (e * f >= 0) return !1;
        var g = (c.x - a.x) * (d.y - a.y) - (c.y - a.y) * (d.x - a.x),
            h = g + e - f;
        return g * h >= 0 ? !1 : !0
    }, b.DetectPolygonsAcross = function(a, b) {
        p1count = a.length, p2count = b.length;
        for (var c = 0; c < p1count; c++) {
            var d, e;
            d = a[c], e = c == p1count - 1 ? a[0] : a[c + 1];
            for (var f = 0; f < p2count; f++) {
                var g, h;
                if (g = b[f], h = f == p2count - 1 ? b[0] : b[f + 1], this.DetectSegmentAcross(d, e, g, h)) return !0
            }
        }
        return !1
    }, b
}();