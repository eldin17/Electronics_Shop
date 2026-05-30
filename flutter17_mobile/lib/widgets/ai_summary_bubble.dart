import 'package:flutter/material.dart';

class AiSummaryBubble extends StatefulWidget {
  final Future<String> Function() onFetchSummary;

  const AiSummaryBubble({Key? key, required this.onFetchSummary}) : super(key: key);

  @override
  State<AiSummaryBubble> createState() => _AiSummaryBubbleState();
}

class _AiSummaryBubbleState extends State<AiSummaryBubble> {
  bool _isExpanded = false;
  bool _isLoading = false;
  String _summaryText = "";

  void _toggleExpand() async {
    if (_isExpanded) {
      // Close it
      setState(() {
        _isExpanded = false;
      });
    } else {
  
      if (_summaryText.isEmpty) {
        setState(() {
          _isLoading = true;
          _isExpanded = true; 
        });

        try {
          final result = await widget.onFetchSummary();
          setState(() {
            _summaryText = result;
          });
        } catch (e) {
          setState(() {
            _summaryText = "Failed to load summary. Please try again.";
          });
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {     
        setState(() {
          _isExpanded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically calculate sizing based on state
    double width = _isExpanded ? MediaQuery.of(context).size.width * 0.9 : 240.0;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(_isExpanded ? 16 : 24),
        border: Border.all(color: Colors.blue.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_isExpanded ? 16 : 24),
          onTap: _isLoading ? null : _toggleExpand, // Disable clicks while loading
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              // --- FIRST: MINIMIZED STATE ---
              firstChild: Row(
                mainAxisSize: MainAxisSize.min,                
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 18),
                  SizedBox(width: 32),
                  Text(
                    "Check AI Summary",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 18),
                          SizedBox(width: 6),
                          Text(
                            "AI Review Insights",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                        onPressed: _toggleExpand,
                      )
                    ],
                  ),
                  const Divider(height: 16, color: Colors.blueAccent),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blueAccent),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Analyzing local customer feedback...",
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 8),
                      child: Text(
                        _summaryText,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}