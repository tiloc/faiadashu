import 'package:faiadashu/questionnaires/view/view.dart' show variant600Opacity;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A hierarchical viewer for any kind of FHIR resource.
///
/// Based on the internal JSON representation of the resource.
class ResourceJsonTree extends StatefulWidget {
  static const defaultAutoExpandLevel = 10;

  const ResourceJsonTree(
    this.resourceRoot, {
    this.autoExpandLevel = defaultAutoExpandLevel,
    super.key,
  });

  final dynamic resourceRoot;
  final int autoExpandLevel;

  /// Create a widget representation of a node in the hierarchical JSON.
  Widget _buildNode(
    _JsonNode? parent,
    String nodeName,
    dynamic nodeValue,
  ) {
    Widget node;
    final nodeRoot = parent != null ? parent.root : this;
    final nodeExpandedDepth =
        (parent != null) ? parent.expandedDepth - 1 : autoExpandLevel;

    const jsonLeftOffset = 8.0;

    if (nodeValue == null) {
      node = _JsonViewerGenericNode(nodeName, nodeValue);
    } else if (nodeValue is Map) {
      node = _JsonViewerMapNode(
        nodeRoot,
        parent,
        nodeName,
        nodeValue as Map<String, dynamic>,
        jsonLeftOffset,
        nodeExpandedDepth,
      );
    } else if (nodeValue is List) {
      node = _JsonViewerListNode(
        nodeRoot,
        parent,
        nodeName,
        nodeValue,
        jsonLeftOffset,
        nodeExpandedDepth,
      );
    } else {
      node = _JsonViewerGenericNode(nodeName, nodeValue);
    }

    return node;
  }

  @override
  State<StatefulWidget> createState() => _ResourceJsonTreeState();
}

class _ResourceJsonTreeState extends State<ResourceJsonTree> {
  _ResourceJsonTreeState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._buildNode(null, '[root]', widget.resourceRoot);
  }
}

abstract class _JsonNode<T> extends StatefulWidget {
  const _JsonNode(
    this.root,
    this.parent,
    this.nodeName,
    this.nodeValue,
    this.leftOffset,
    this.expandedDepth, {
    super.key,
  });

  final ResourceJsonTree root;
  final _JsonNode? parent;
  final String nodeName;
  final T nodeValue;
  final double leftOffset;
  final int expandedDepth;

  List<Widget> buildChildren();
}

abstract class _JsonNodeState<T extends _JsonNode> extends State<T> {
  late bool isOpen;

  @override
  void initState() {
    super.initState();
    isOpen = widget.expandedDepth > 0;
  }

  void toggleOpen() {
    setState(() {
      isOpen = !isOpen;
    });
  }
}

class _JsonViewerMapNode extends _JsonNode<Map<String, dynamic>> {
  const _JsonViewerMapNode(
    super.root,
    super.parent,
    super.nodeName,
    super.nodeValue,
    super.leftOffset,
    super.expandedDepth,
  );

  @override
  State<StatefulWidget> createState() => _MapNodeState();

  @override
  List<Widget> buildChildren() {
    final result = <Widget>[];
    nodeValue.forEach((k, v) {
      result.add(root._buildNode(this, k, v));
    });

    return result;
  }
}

/// Display maps as key-value pairs
class _MapNodeState extends _JsonNodeState<_JsonViewerMapNode> {
  @override
  Widget build(BuildContext context) {
    Widget result = GestureDetector(
      onTap: () => toggleOpen(),
      child: Row(
        children: <Widget>[
          Icon(
            isOpen ? Icons.arrow_drop_down : Icons.arrow_right,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text(
            widget.nodeName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
    if (isOpen) {
      result = Column(
        children: <Widget>[
          result,
          Padding(
            padding: EdgeInsets.only(left: widget.leftOffset),
            child: Column(
              children: widget.buildChildren(),
            ),
          ),
        ],
      );
    }

    return result;
  }
}

/// Display a list of JSON entries
class _JsonViewerListNode extends _JsonNode<List<dynamic>> {
  const _JsonViewerListNode(
    super.root,
    super.parent,
    super.nodeName,
    super.nodeValue,
    super.leftOffset,
    super.expandedDepth,
  );

  @override
  State<StatefulWidget> createState() => _JsonViewerListNodeState();

  @override
  List<Widget> buildChildren() {
    final result = <Widget>[];
    var i = 0;
    for (final entry in nodeValue) {
      result.add(root._buildNode(this, '[$i]', entry));
      i++;
    }

    return result;
  }
}

class _JsonViewerListNodeState extends _JsonNodeState<_JsonViewerListNode> {
  @override
  Widget build(BuildContext context) {
    final count = widget.nodeValue.length;
    final themeData = Theme.of(context);

    Widget result = GestureDetector(
      onTap: () => toggleOpen(),
      child: Row(
        children: <Widget>[
          if (count > 0)
            Icon(
              isOpen ? Icons.arrow_drop_down : Icons.arrow_right,
              color: Theme.of(context).colorScheme.secondary,
            ),
          Text(
            widget.nodeName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            ' ($count)',
            style: (count > 0)
                ? TextStyle(
                    color: themeData.textTheme.bodyLarge?.color
                        ?.withOpacity(variant600Opacity),
                  )
                : TextStyle(color: themeData.colorScheme.error),
          ),
        ],
      ),
    );
    if (isOpen) {
      result = Column(
        children: <Widget>[
          result,
          Padding(
            padding: EdgeInsets.only(left: widget.leftOffset),
            child: Column(
              children: widget.buildChildren(),
            ),
          ),
        ],
      );
    }

    return result;
  }
}

class _JsonViewerGenericNode extends StatelessWidget {
  final String nodeName;
  final dynamic nodeValue;

  const _JsonViewerGenericNode(this.nodeName, this.nodeValue);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    var color = themeData.textTheme.bodyLarge?.color;
    if (nodeValue == null) {
      color = themeData.colorScheme.error;
    } else {
      switch (nodeValue.runtimeType) {
        case bool:
          color = (nodeValue as bool)
              ? themeData.colorScheme.secondary
              : themeData.colorScheme.error;
          break;
        case int:
          color = themeData.colorScheme.secondary;
          break;
      }
    }

    const infiniteLines = 999;

    final nodeString = nodeValue.toString();
    final nodeDisplay = (nodeString.length < 500)
        ? nodeString
        : '${nodeString.substring(0, 500)}…';

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            nodeName,
            style: TextStyle(
              color: themeData.textTheme.bodyLarge?.color
                  ?.withOpacity(variant600Opacity),
            ),
          ),
          const Text(' : '),
          if (nodeValue != null)
            Expanded(
              child: GestureDetector(
                child: Text(
                  nodeDisplay,
                  softWrap: true,
                  maxLines: infiniteLines,
                  style: TextStyle(color: color),
                ),
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: nodeValue.toString(),
                    ),
                  ).then((_) {
                    final messenger = ScaffoldMessenger.maybeOf(context);
                    messenger?.clearSnackBars();
                    messenger?.showSnackBar(
                      SnackBar(
                        content: Text(
                          '$nodeName copied to clipboard',
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          if (nodeValue == null)
            Text(
              'null',
              style: TextStyle(color: themeData.colorScheme.secondary),
            ),
        ],
      ),
    );
  }
}
