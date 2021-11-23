//
//  CustomTextField.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 14/11/21.
//

import UIKit

@IBDesignable
public class CustomTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Properties
    private var underLineLayer = CALayer()
    private var validator: ((String) -> Bool)?
    @IBInspectable public var underLineWidth: CGFloat = 1.0 {
        didSet { updateUnderLineFrame() }
    }
    @IBInspectable public var underLineColor: UIColor = UIColor.appColor(.separatorLineColor) ?? .clear {
        didSet { updateUnderLineUI() }
    }
    @IBInspectable public var placeholderColor: UIColor = UIColor.appColor(.placeholderColor) ?? .clear {
        didSet { decorate() }
    }
    public override var placeholder: String? {
        didSet { decorate() }
    }
    @IBInspectable public var placeholderFontName: String? = FontName.regularItalicSF.rawValue {
        didSet { decorate() }
    }
    @IBInspectable public var placeholderFontSize: CGFloat = 15 {
        didSet { decorate() }
    }
    @IBInspectable public var placeholderLetterSpacing: CGFloat = 0 {
        didSet { decorate() }
    }
    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        applyStyles()
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyles()
        setup()
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateUnderLineFrame()
    }
    
    // MARK: - Styles
    private func applyStyles() {
        applyUnderLine()
    }
    
    private func decorate() {
        let font = UIFont(name: FontName.regularSF.rawValue, size: placeholderFontSize)
        var titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.kern: placeholderLetterSpacing
        ]
        titleAttributes[NSAttributedString.Key.font] = font
        defaultTextAttributes = titleAttributes
        var placeholderAttributes = titleAttributes
        let placeholderFont = UIFont(name: placeholderFontName!, size: placeholderFontSize)
        placeholderAttributes[NSAttributedString.Key.foregroundColor] = placeholderColor
        placeholderAttributes[NSAttributedString.Key.font] = placeholderFont
        let placeholder = self.placeholder ?? ""
        let attributedPlaceholder = NSMutableAttributedString(string: placeholder, attributes: placeholderAttributes)
        self.attributedPlaceholder = attributedPlaceholder
    }
    
    // MARK: - Underline
    private func applyUnderLine() {
        // Apply underline only if the text view's has no borders
        if borderStyle == .none {
            underLineLayer.removeFromSuperlayer()
            updateUnderLineFrame()
            updateUnderLineUI()
            layer.addSublayer(underLineLayer)
            layer.masksToBounds = true
        }
    }
    
    private func updateUnderLineFrame() {
        var rect = bounds
        rect.origin.y = bounds.height - underLineWidth
        rect.size.height = underLineWidth
        underLineLayer.frame = rect
    }
    
    private func updateUnderLineUI() {
        underLineLayer.backgroundColor = underLineColor.cgColor
    }
    
    private func setup() {
        delegate = self
        addTarget(self,
                  action: #selector(textFieldDidBeginEditing(_:)),
                  for: .editingDidBegin)
        addTarget(self,
                  action: #selector(textFieldDidEndEditing(_:reason:)),
                  for: .editingDidEnd)
    }
    
    // MARK: - UITexfield
    @objc public func textFieldDidBeginEditing(_ textField: UITextField) {
        setStyleColor(true)
    }
    
    @objc public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let value = text, value.isEmpty {
            setStyleColor(false)
            return
        }
        setStyleColor(true)
    }
    
    @objc public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextFields = viewWithTag(textField.tag + 1) as? UITextField {
            nextFields.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func setStyleColor(_ isValid: Bool) {
        if isValid {
            textColor = UIColor.black
            underLineLayer.backgroundColor = UIColor.appColor(.separatorLineColor)?.cgColor
        } else {
            let color = UIColor.appColor(.unavailableColor)
            textColor = color
            underLineLayer.backgroundColor = color?.cgColor
        }
    }
    
    func setValidator(_ validator: @escaping (String) -> Bool) {
        self.validator = validator
    }
    
    @objc func isValidField() -> Bool {
        guard let isValidField = validator,
              let text = self.text
        else { return true }
        let result = isValidField(text)
        setStyleColor(result)
        return result
    }
}
